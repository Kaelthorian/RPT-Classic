# UI, administration, and communication

## Purpose and scope

This system connects DM code to BYOND windows/macros and browser content, routes
IC/OOC/combat/admin messages, and exposes privileged administration workflows.

## Main flow and key code

`RT.dmf` declares the interface, controls, and macros. `Code/Modules/Comms/client.dm`
initializes client windows; `Code/Mob/Windows/`, `Code/Modules/Tabs/`, and verbs
populate controls with `winset`, `winshow`, and `output`. `assets/` contains
tooltip/map-size HTML, CSS, and JavaScript; `Code/Modules/Tooltips/` bridges it.

`Code/Modules/Comms/Better Communication.dm:52-94` centralizes `AllOut`, `ICOut`,
`OOCOut`, `CombatOut`, `HelpOut`, and `AdminOut`. Say/OOC/whisper verbs handle
audience/language/filtering. `mob/Topic` and `/obj/admins/Topic` process link
actions. Admin rank/verb setup is in `Code/Modules/Admin/AdminUpdateVerb.dm` and
the large `Admin/Verbs/` tree. Discord notification code uses
`Code/Modules/Discord/HttpPost.dm` and browser output to named DMF controls.

## Types, state, inputs, outputs, dependencies

Types include `client`, `/mob/player`, `/obj/admins`, admin tier mob paths, and
contact/help datums. Inputs are verbs, DMF controls, browser href parameters,
chat text, targets, and rank state. Outputs are named UI controls, recipient
messages, logs, admin mutations, and external HTTP posts. Dependencies include
`Players`, `client.holder`/rank level, spam/mute/ignore/language helpers, save and
ban systems, and world settings.

Invariants: every sensitive Topic/verb action must authenticate the current
holder and required level; `src.owner` must match for admin panels; user text
must be bounded/sanitized for its destination; and external credentials must not
be committed. `Admin/Topic.dm:1-8` provides an important owner/holder gate, with
per-action rank checks following it.

## Risks and validation

Multiple active files contain complete Discord webhook URLs and world/hub
credentials (SEC-001). Do not copy their values into issues or docs. The
multikey admin verb has an always-true intended-exclusion condition
(`MultikeyCheck.dm:6`, ADMIN-001).

Validate permission matrices for every admin rank, forged Topic links, stale
panel ownership, mute/ignore/language audience, maximum-length/untrusted text,
client disconnects, and mocked external HTTP failures. Search `client.holder`,
`holder.level`, `/obj/admins/Topic`, `winset`, `winshow`, `browse`, `output`,
`ICOut`, `OOCOut`, `AdminOut`, `HttpPost`, and `api/webhooks`.
