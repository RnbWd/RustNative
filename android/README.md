# Android — selected, not scaffolded

The default first app targets Android phones using Kotlin and Jetpack Compose. No Gradle
project or app exists yet. Android tablets are optional. Choose identifiers, minimum API,
SDK/NDK versions, and device ABIs when building a real app.

Read [AGENTS.md](AGENTS.md), [project selection](../docs/PROJECT.md), and the
[activation checklist](../docs/TOOLCHAIN.md). Use the repository's
[Android skill](../.agents/skills/native-android/SKILL.md) for platform work.

## First implementation

Create a small native app and an adapter to generated UniFFI Kotlin bindings. Native code owns
screens, view state, navigation, lifecycle, permissions, secure storage, and Android services.
Rust owns portable product rules. Keep expensive core calls off the main thread and define
core-object ownership explicitly.

Verify a Rust call and typed error in an actual release app, including JNA packaging, R8,
ABI/API compatibility, and 16 KB native-library alignment. Then deliver one useful feature.
Keep Apple dormant and retain a small [port packet](../docs/PARITY.md) once behavior exists.

## Setup, build, and run

Use `./scripts/devices.sh android` from the repo root to list devices/AVDs with installed SDK tools,
or `./scripts/bootstrap.sh android` for the setup checklist. Build/install/run entry points are
[placeholders](../scripts/README.md) until scaffolded. Then document the selected JDK,
SDK/NDK setup, Rust generation/build order, exact Gradle checks, artifact paths, and device
run instructions. Document debug, local signed release, and store distribution separately.
Update `organizermd.json` with the real commands. Never commit signing keys or machine-specific
device IDs; use the [device-selection rules](../docs/ORGANIZERMD.md#device-selection).
