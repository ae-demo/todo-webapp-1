# todo-webapp-1 — PRD

## Problem Statement

People juggle small, everyday tasks in their heads, on scraps of paper, or across chat threads and notes apps that were never built for the job. Things get forgotten, and there's no single, private place to see everything that still needs doing.

## Solution

A simple, personal todo web app. Each user signs in and manages their own flat list of tasks — add, edit, complete, and delete — with nothing more to configure and nothing to set up. It's the fast, no-friction home for "what do I still need to do today."

## Actors

- **User** — a signed-in individual who manages their own private list of tasks: adding, viewing, editing, completing, and deleting them. No user can see or affect another user's tasks.

## User Stories

1. As a User, I want to sign in securely, so that my task list is private to me.
2. As a User, I want to add a new task with a short description, so that I can capture something I need to do.
3. As a User, I want to view my list of tasks, so that I can see everything I still need to do.
4. As a User, I want to mark a task as complete, so that I can track what I've finished.
5. As a User, I want to un-mark a task as complete, so that I can reopen something I marked done by mistake or need to redo.
6. As a User, I want to edit a task's text, so that I can correct or update it.
7. As a User, I want to delete a task, so that I can remove things I no longer need to do.
8. As a User, I want completed tasks kept visually separate from active ones, so that my active list stays uncluttered.

## Product Decisions

- Sign-in is via SSO through Thunder, the platform IDP, for every user *(org default)*.
- The app is personal-only: each user sees and manages only their own tasks, with no sharing or collaboration *(assumed)*.
- Tasks form a single flat list — no categories, projects, due dates, or priority levels *(assumed)*.
- No reminder or notification channel is sent for tasks; users check the app directly *(assumed)*.

## Phasing

- **Phase 1 — Ship a personal, sign-in-protected flat todo list**: deliver secure sign-in and full task CRUD (add, view, edit, complete/reopen, delete) with completed tasks kept visually separate. Stories: 1, 2, 3, 4, 5, 6, 7, 8.

## Out of Scope

- Sharing or collaborating on lists/tasks with other users.
- Due dates, priorities, categories, projects, or tags on tasks.
- Reminders or notifications (email, push, or otherwise).
- Recurring tasks, subtasks, or attachments.
- Mobile native apps (this is a single web app).

## Open Questions

None — the interview converged on a minimal, personal, flat-list scope.