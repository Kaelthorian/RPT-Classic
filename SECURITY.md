# Security and protected data policy

## Immediate repository risk

The public repository contains production-like secrets in source, including Discord
webhook URLs and server credentials. Assume every committed value is compromised.
The correct response is to revoke or rotate it at the provider and replace source
literals with runtime configuration. Removing a secret from the latest commit alone
does not remove it from Git history.

Codex must never print, quote, summarize, copy, validate, or reuse secret values. It
may identify a file and line category without reproducing the credential.

## Protected paths

Treat these as deny-by-default:

- `Data/Saves`: player characters and backups.
- `Data/Logs` and other runtime logs.
- Ban, admin, key, login, item-serial, and database files under `Data`.
- Compiled artifacts (`*.dmb`, `*.rsc`, `*.dyn.rsc`, `*.int`).
- `.local-tools` and third-party compiler/tool installations.
- Production maps and binary resources unless the task explicitly targets them.

Do not use real files from protected paths as fixtures. Create synthetic data in the
operating system's temporary directory and delete it after the test.

## Secret-management target design

A dedicated remediation should:

1. Revoke all exposed Discord webhooks and rotate server credentials.
2. Inventory every URL/token/password using local secret scanning without displaying
   values in chat or reports.
3. Load secrets from a local, ignored configuration source or environment variables.
4. Fail integrations closed when configuration is missing.
5. Keep test endpoints separate from production endpoints.
6. Ensure logs and admin messages never include credentials.
7. Purge secrets from Git history only after backups and coordination; history rewrite
   is destructive and requires explicit authorization.

Do not invent a new encryption scheme inside DM. Configuration separation and provider
rotation are the primary controls.

## Discord and HTTP rules

The Discord module sends HTTP through hidden browser JavaScript in the BYOND client.
For any change:

- Never invoke a committed endpoint during tests.
- Pass the actor/client explicitly; do not rely on `usr` in reusable network procs.
- Sanitize and length-limit user-controlled content.
- Avoid mass mentions and uncontrolled markdown injection.
- Handle missing client, missing configuration, network failure, and rate limiting.
- Do not allow a normal player to choose arbitrary destination URLs.
- Log only safe metadata, not credentials or full private messages.

## Admin and server-control rules

Admin verbs can mutate players, saves, world state, bans, and server lifecycle.
Preserve or strengthen authorization checks and audit logging. Never widen access,
remove logs, or make a privileged operation callable from a normal player path without
an explicit security requirement and review.

## Public reporting

Security reports may include:

- File path.
- General secret type.
- Whether it appears active or production-like.
- Recommended rotation/remediation.

They must not include the secret value, a partially masked value that remains usable,
or a copyable endpoint.
