# Phase 1: PostgreSQL Fundamentals - Day 4

## 1. The Necessity of Dynamic Updates

In aviation maintenance, data is never static. We need reliable ways to modify existing records:

- **Flight Hour Accumulation**: Incrementing hours after each flight leg.
- **Component Status Changes**: Transitioning parts through 'Serviceable', 'Unserviceable', or 'Under Repair'.

## 2. Standard UPDATE Syntax

The `UPDATE` statement modifies existing rows. Key best practices include:

- **Filtering with WHERE**: Critical to prevent updating the entire fleet by mistake.
- **RETURNING Clause**: Verifying the new values immediately after the update.

## 3. The Power of UPSERT (ON CONFLICT)

"Upsert" is a hybrid of UPDATE and INSERT. It handles scenarios where you try to insert a record that already exists (based on a Unique Constraint):

- **DO NOTHING**: Skip the insertion if the record exists.
- **DO UPDATE**: Update the existing record with new information if a conflict occurs.
- **Use Case**: Daily synchronization of fleet metrics where some aircraft are new and others just need their hours updated.
