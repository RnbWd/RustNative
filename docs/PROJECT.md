# Project selection

This file is the current selection, not a build configuration. Agents read it before choosing
work or tooling. Update it when the user selects a primary target or changes the active targets.

| Setting | Current value |
| --- | --- |
| Project | RustNative reusable starter |
| Phase | Starter docs and tooling; no app scaffolded |
| App purpose | Not chosen; define in a derived project |
| Primary target | Unset |
| Active targets | None |
| Coordination | `solo` |
| Shared core and consumers | Unset. Record Rust and its consumers if selected |
| Persistence / networking / server | None selected |
| Browser framework / browser coverage | Choose for the first feature |
| Android baseline if activated | Android 16 (API 36); no older Android support planned |
| Identifiers / Apple minimum OS / architectures | Choose at activation |
| Integration owner | Current working agent until explicitly reassigned |

## Target rules

- Choose one primary target from `web`, `android`, `ios`, `ipados`, and `macos`. Include it in the
  active list. The primary target guides the first feature and provides a reference for ports.
- List every target to build and verify. Examples include `[android]`, `[web]`, `[ios, ipados]`,
  and `[web, android, macos]`. The same workflow applies to any mix.
- Targets outside the list are deferred. Select iPhone, iPad, and Mac independently even if
  they share code or an Xcode scheme.

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
