# Apple — dormant, not scaffolded

No Xcode project, Swift package, or Apple app exists. This directory documents future Swift +
SwiftUI work. Activate **iOS, iPadOS, and/or macOS explicitly** in [project selection](../docs/PROJECT.md).
Android-only work requires no Apple SDK, project, bindings, or build.

When activated, read [AGENTS.md](AGENTS.md), the [activation checklist](../docs/TOOLCHAIN.md),
and the repository's [Apple skill](../.agents/skills/native-apple/SKILL.md).

## First implementation

Use a native app with a small adapter to generated UniFFI Swift bindings. Native code owns
view state, navigation, accessibility, scene lifecycle, secure storage, and device services.
Rust owns portable product rules. Select a concurrency/executor model that keeps heavy calls
off the UI executor; an actor alone is not a dedicated blocking worker.

Package Rust for selected device/simulator destinations, and verify an actual call and typed
error. Use the leading platform's [port evidence](../docs/PARITY.md) as a behavior reference.
Adapt navigation and layout to Apple conventions rather than copying pixels automatically.

Add iPad adaptive layouts or macOS window/keyboard behavior only if those targets are selected.
Record their checks separately; a successful macOS build does not establish iOS behavior.

## Setup, build, and run

`./scripts/bootstrap.sh ios` prints a checklist without activating Apple or creating a project.
`./scripts/devices.sh ios` lists available devices using installed Xcode tools. Native task scripts
are [placeholders](../scripts/README.md). When scaffolded, document the selected Xcode,
deployment targets, Rust/framework generation steps, exact scheme/destination build commands,
and simulator/device run instructions. Update `organizermd.json` and use its
[device-selection rules](../docs/ORGANIZERMD.md#device-selection). Explain local signing requirements.
