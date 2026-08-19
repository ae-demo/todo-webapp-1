# todo-webapp-1 — Design

## Overview

A minimal, personal todo application. Users sign in via Thunder SSO and use a
single-page React app (`todo-webapp`) to manage their own flat list of tasks.
The webapp holds no data itself: every read or write goes through the
Ballerina backend (`todo-api`), which persists tasks in its own database and
scopes every operation to the signed-in caller's identity, resolved from the
Thunder-validated token injected by the gateway.

## Context (C1)

```mermaid
graph LR
  user[User]
  system((todo-webapp-1))
  thunder[[Thunder — Platform IDP]]

  user -->|signs in, manages tasks| system
  system -->|OIDC sign-in / token validation| thunder
```

## Domain model (ER)

```mermaid
erDiagram
  USER {
    string id
    string email
    string displayName
  }
  TASK {
    string id
    string ownerId
    string text
    boolean completed
    datetime createdAt
    datetime updatedAt
  }
  USER ||--o{ TASK : owns
```

`USER` is resolved from the Thunder-validated token, not stored by this
system beyond the id used to scope tasks. `TASK` is the only entity `todo-api`
persists.

## Key flows

### Sign in

```mermaid
sequenceDiagram
  participant U as User
  participant W as todo-webapp
  participant T as Thunder
  participant A as todo-api

  U->>W: Open app
  W->>T: Redirect to sign-in (OIDC + PKCE)
  T->>W: Redirect back with auth code
  W->>T: Exchange code for tokens
  T-->>W: Access + ID token
  W->>A: GET /tasks (Bearer token)
  A->>T: Validate token (via gateway)
  A-->>W: 200 tasks for signed-in user
```

### Add and complete a task

```mermaid
sequenceDiagram
  participant U as User
  participant W as todo-webapp
  participant A as todo-api

  U->>W: Enter task text, submit
  W->>A: POST /tasks {text}
  A-->>W: 201 created task
  U->>W: Mark task complete
  W->>A: PATCH /tasks/{taskId} {completed: true}
  A-->>W: 200 updated task
  W-->>U: Task moves to completed section
```

### Edit and delete a task

```mermaid
sequenceDiagram
  participant U as User
  participant W as todo-webapp
  participant A as todo-api

  U->>W: Edit task text, save
  W->>A: PATCH /tasks/{taskId} {text}
  A-->>W: 200 updated task
  U->>W: Delete task
  W->>A: DELETE /tasks/{taskId}
  A-->>W: 204 no content
  W-->>U: Task removed from list
```