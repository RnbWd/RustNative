# Script entry points

Run from the project root, or invoke a script by its path from another directory. Bash and
Python 3.9+ are sufficient for template checks. No native app or toolchain is installed by these scripts.

| Script | Works now | Wire up when an app exists |
| --- | --- | --- |
| `test.sh template` | Shell syntax, OrganizerMD references/paths, cleanup boundary checks | Keep alongside focused app tests |
| `devices.sh android` | Lists connected devices and available AVDs using installed SDK tools | Use the discovered targets in a chooser |
| `devices.sh ios` | Lists Apple simulators and physical devices using Xcode tools | Filter by selected platform/deployment target |
| `clean.sh` | Previews a fixed allowlist of repo-local build folders | Adjust the allowlist for real output paths |
| `clean.sh --apply` | Removes those build folders; rejects symlink paths | Stop builds first; preserve app data and global caches |
| `bootstrap.sh android\|ios\|macos` | Prints a setup checklist; makes no changes | Optional app-specific project generator |
| `build.sh TARGET debug\|release [simulator\|device]` | Placeholder; exits 2 | Rust → bindings → native build; never launch |
| `test.sh core\|android\|android-device\|ios\|macos` | Placeholder; exits 2 | Focused tests/checks for active targets |
| `install.sh TARGET device\|emulator\|simulator debug\|release` | Placeholder; exits 2 | Install a validated existing artifact; preserve data/signature |
| `run.sh TARGET DESTINATION debug\|release` | Placeholder; exits 2 | Choose, build, boot if needed, install, launch |
| `emulator.sh android\|ios` | Placeholder; exits 2 | Choose and boot only; no app build/install |

All shell entry points accept `--help`. A placeholder must never report a successful build,
installation, or launch. Inline comments identify what a future agent should implement.
There is no native SDK requirement for displaying help, printing checklists, or reporting an
unfinished task. Apple entries in OrganizerMD are dormant examples; they do not activate Apple.

## Useful starter commands

```sh
./scripts/test.sh template
./scripts/bootstrap.sh android
./scripts/clean.sh
```

The clean preview is read-only. The allowlist contains `build`, `target`, `android/build`,
`android/app/build`, `apple/build`, `apple/.build`, and `apple/DerivedData`. It never removes
SDK installations, global Cargo/Gradle caches, device data, signing files, or source directories.

## Implementing the entry points

Use `android`, `ios`, or `macos` as an explicit target. `ios` covers the selected iPhone/iPad
destinations; `desktop` is the macOS run destination. Reject invalid target/configuration pairs.
Read [project selection](../docs/PROJECT.md) and reject inactive targets when wiring native tasks.
Avoid `all` until there is an explicit active-target configuration to expand safely.

Make arguments such as `--device ID`, `--avd NAME`, and `--no-build` real only when implemented.
Use the [selection rules](../docs/ORGANIZERMD.md#device-selection) for launch/install/device tests.
Keep per-repo preferences in ignored `.env.local`, loaded explicitly by the future launcher;
the current scripts do **not** source it. Do not commit serials, UDIDs, or signing settings.

Update [organizermd.json](../organizermd.json) and [the OrganizerMD guide](../docs/ORGANIZERMD.md)
with each script change. Remove the setup-needed labels only after verifying the actual command.
Native code, identifiers, schemes, artifacts, signing, and minimum OS choices remain app-specific.
