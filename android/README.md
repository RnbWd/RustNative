# Android — deferred, not scaffolded

When selected, the default direct native UI is Kotlin and Jetpack Compose. Target and test
Android 16 (API 36); there is no older Android support requirement. No Gradle project exists.
Choose identifiers, compatible SDK tooling, and device ABIs when activating Android.

Read [AGENTS.md](AGENTS.md), [project selection](../docs/PROJECT.md), and the
[activation checklist](../docs/TOOLCHAIN.md). Use the repository's
[Android skill](../.agents/skills/native-android/SKILL.md) for platform work.

## First implementation

Create one useful Compose feature. Android code owns screens, navigation, lifecycle, permissions,
secure storage, and device services. If the app uses Rust through UniFFI, put the generated
Kotlin bindings behind a small adapter and follow the release checks in the Android skill.
Keep inactive targets dormant and retain a small [port packet](../docs/PARITY.md) once behavior exists.

## Setup, build, and run

Use `./scripts/devices.sh android` from the repo root to list devices/AVDs with installed SDK tools,
or `./scripts/bootstrap.sh android` for the setup checklist. Build/install/run entry points are
[placeholders](../scripts/README.md) until scaffolded. Then document the selected JDK,
SDK setup, any Rust build steps, exact Gradle checks, artifact paths, and device
run instructions. Document debug, local signed release, and store distribution separately.
Update `organizermd.json` with the real commands. Never commit signing keys or machine-specific
device IDs; use the [device-selection rules](../docs/ORGANIZERMD.md#device-selection).
