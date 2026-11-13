# Apple — dormant, not scaffolded

No Xcode project, Swift package, or Apple app exists. This directory documents future Swift +
SwiftUI work, with AppKit where macOS needs it. Activate **iOS, iPadOS, and/or macOS explicitly**
in [project selection](../docs/PROJECT.md).

When activated, read [AGENTS.md](AGENTS.md), the [activation checklist](../docs/TOOLCHAIN.md),
and the repository's [Apple skill](../.agents/skills/native-apple/SKILL.md).

## First implementation

Build one useful native feature. Apple code owns view state, navigation, accessibility, scene
lifecycle, secure storage, and device services. If the app uses Rust through UniFFI, put the
generated Swift bindings behind a small adapter and follow the release checks in the Apple skill.
For a port, use the primary target's [evidence](../docs/PARITY.md) as a behavior reference.

Add iPad adaptive layouts or macOS window/keyboard behavior only if those targets are selected.
Record their checks separately; a successful macOS build does not establish iOS behavior.

## Setup, build, and run

`./scripts/bootstrap.sh ios`, `./scripts/bootstrap.sh ipados`, and `./scripts/bootstrap.sh macos`
print Apple setup checklists.
`./scripts/devices.sh ios` lists available devices using installed Xcode tools. Native task scripts
are [placeholders](../scripts/README.md). When scaffolded, document the selected Xcode,
deployment targets, any Rust/framework generation steps, exact scheme/destination build commands,
and simulator/device run instructions. Update `organizermd.json` and use its
[device-selection rules](../docs/ORGANIZERMD.md#device-selection). Explain local signing requirements.
