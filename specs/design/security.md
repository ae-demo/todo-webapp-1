# todo-webapp-1 — Security design

## Roles → permissions

There is a single role (`User`) — the PRD defines one actor and no
administrative or shared-access surface.

## Authentication (Thunder)

- Shared `thunder-app` dependency name: **`todo-auth`**, declared identically
on `todo-webapp` and `todo-api` — this shared name ties the SPA's sign-in
session to the bearer tokens `todo-api` validates.
- Scopes: `openid profile email` (default).
- Sign-in side: `todo-webapp` (SPA, OIDC + PKCE via Thunder).
- Protected side: `todo-api` (every `/tasks` endpoint requires a valid
bearer token; the gateway validates it and injects the caller's identity).

## Role resolution

`todo-api` resolves the caller from the identity header the gateway injects
from the validated Thunder token (the user's subject/id claim) — it never
reads or trusts an id supplied by the client. There is only one role, so any
successfully authenticated caller is a `User` scoped to their own tasks; a
request with no valid token is rejected (401), deny by default.