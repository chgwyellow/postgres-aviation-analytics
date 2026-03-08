/*
 * Project: Postgres Aviation Analytics
 * Phase: 6 - Final Performance Mastery
 * Day: 30 - Concurrency & Locking Strategy
 */
SET search_path TO core_ops,
    public;
-- Simulate high volume concurrency
BEGIN;
-- Searching for the 'Pending' orders and lock it then skipping locked rows
WITH next_task AS (
    SELECT task_id
    FROM core_ops.fact_maintenance_tasks
    WHERE status = 'Pending'
    ORDER BY created_at DESC
    LIMIT 1 FOR
    UPDATE SKIP LOCKED -- skip current row if someone is dealing with it
)
UPDATE core_ops.fact_maintenance_tasks
SET status = 'In_Progress'
WHERE task_id = (
        SELECT task_id
        FROM next_task
    )
RETURNING *;
COMMIT;
-- Advisory Lock
-- Assuming you don't want anyone to do the same thing
SELECT pg_try_advisory_lock(1001);
-- Return t means you got it, f means someone is using it.
-- Release lock
SELECT pg_advisory_unlock(1001);