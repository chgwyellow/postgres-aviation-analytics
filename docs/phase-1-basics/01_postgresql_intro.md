# Phase 1: PostgreSQL Fundamentals - Day 1

## 1. Project Overview

Establishing a professional PostgreSQL environment for aviation maintenance analytics. This project focuses on transitioning from MySQL to PostgreSQL while implementing industry-standard data modeling and Git workflows.

## 2. Core Architecture: PostgreSQL vs. MySQL

PostgreSQL is an Object-Relational Database Management System (ORDBMS) with a hierarchical structure:

- **Instance**: The database server running on your local machine.
- **Database**: The top-level logical container (e.g., `aviation_analytics`).
- **Schema**: A namespace within a database used to organize objects and manage permissions. Unlike MySQL (where Database and Schema are often synonymous), PostgreSQL allows multiple Schemas per Database.
- **Table**: The final storage layer for structured data.

## 3. Tooling & Workflow

- **IDE**: Antigravity (Integrated version control and project management).
- **Client**: DBeaver (SQL execution and visualization).
- **Git Strategy**:
  - Use `main` for stable, production-ready code.
  - Use `feature/phase-x-description` for daily development.
  - Practice merging to simulate team collaboration.

## 4. Initialization Objectives

- Initialize project directory structure.
- Create a dedicated schema `core_ops` to isolate aviation operational data.
- Configure `search_path` for efficient querying.
