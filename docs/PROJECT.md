# Project selection

This file is the current selection, not a build configuration. Agents read it before choosing
work or tooling. Change it when the user chooses a different mode or activates a target.

| Setting | Current value |
| --- | --- |
| Project | RustNative reusable starter |
| Phase | Starter docs and tooling; no app scaffolded |
| App purpose | Not chosen; define in a derived project |
| Mode | `android-only` |
| Active targets | Android phones |
| Apple targets | None; choose iOS, iPadOS, and/or macOS when activated |
| Coordination | `solo` |
| Leading platform | Android (planned; no implemented reference app) |
| Shared core | Rust + Mozilla UniFFI (selected design; not scaffolded) |
| Persistence / networking / server | None selected |
| Identifiers / minimum OS / architectures | Choose at activation |
| Integration owner | Current working agent until explicitly reassigned |

## Mode rules

- `android-only`: work on Android and applicable Rust code. Apple is deferred.
- `apple-only`: work on selected Apple targets and applicable Rust code. Android is deferred.
- `dual`: work on Android and selected Apple targets; track each target's evidence separately.

Use `solo` coordination by default. `threads` means two user-requested platform chats plus
an assigned integration owner. `subagents` means a user-selected coordinator workflow with
one Android worker and one Apple worker. Follow [WORKFLOW.md](WORKFLOW.md).

Supporting Android tablets, iPadOS, or macOS is a separate product decision. Do not add
desktop features or require all device families because they appear in the architecture.

## Adoption checklist

- Define the app's first useful feature and what remains out of scope in [PRODUCT.md](PRODUCT.md).
- Choose active targets, identifiers, minimum OS versions, and required device architectures.
- Activate only those targets through [TOOLCHAIN.md](TOOLCHAIN.md).
- Wire the script entry points and update [OrganizerMD](ORGANIZERMD.md) alongside real app commands.
- Replace the starter README's status and start instructions with the app's own setup/run guide.
- Keep the MIT notice for reused starter material; document the derived app's licensing choices.
- Add app-specific rules only when they change how work should be done. Remove unused template notes.

No credentials, deployment destinations, or device-specific paths belong here.
