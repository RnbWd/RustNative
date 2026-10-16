# OrganizerMD integration

[organizermd.json](../organizermd.json) is the shared dashboard configuration. It uses version 2
with six actions: Build, Test, Run, Install, Devices, and Tools. Variants live in menus and refer
to commands defined once. Build/launch/install entries are labeled unfinished until an app exists.

Template validation, device inventory, cleanup, and bootstrap checklists work now; see
[scripts/README.md](../scripts/README.md). Clicking an unfinished native task prints its next
implementation step and exits 2. No imaginary `.app` paths or automatically run setup commands
are registered. Add `apps` only after the real macOS output path exists.

## Keep the dashboard current

When scaffolding a platform or changing a developer command:

1. Implement the corresponding script with the actual project, scheme, artifact, and configuration.
   Keep build, install, launch, and emulator-only operations distinct.
2. Update its command and action options in `organizermd.json`; verify the invocation before
   removing setup-needed labels. Keep Android as primary until the project mode changes.
3. Remove unneeded inactive-platform menu entries in a derived app, or keep them clearly dormant.
   Add debug/release, simulator/device, and no-build options only as the scripts implement them.
4. Retain app-managed `hiddenCommands`, `inspector`, and any existing command `snapshot` objects.
   Preserve unrelated config edits. Keep documentation references and README commands current.
5. Run `./scripts/test.sh template` and focused checks for the implemented task. Template checks
   cover JSON references, shell syntax, and cleanup boundaries; they do not prove an app builds or installs.

## Keep build output out of document scanning

The `documents.exclude` patterns explicitly exclude nested Cargo `target`, generic `build`,
Swift `.build`/`DerivedData`, Gradle/Kotlin/Swift caches, generated code, dependencies, and bundles.
A leading `**/` matches at any depth, including a workspace crate's `target`. Exclude the folder
itself, so the scanner can prune it before visiting thousands of build files.

Keep `documents.include` empty unless generated documentation is intentionally required. When
adding a custom `CARGO_TARGET_DIR`, Xcode output, or downloaded dependency tree inside the repo,
add that relative folder to the exclusions in the same change. Build outside the repo when useful.
These are document-list/live-refresh exclusions; build artifacts still contribute to OrganizerMD's
size measurement, and configured apps can still open. They are separate from `.gitignore`.

## Device selection

Future launch/install scripts should discover current candidates, then:

- Respect an explicit `--device ID` or `--avd NAME`, validating availability and compatibility.
- Otherwise use a validated preference from that repository's ignored local config, if provided.
- Otherwise use the sole compatible candidate. If there are several, show a numbered terminal
  menu; without an interactive terminal, list choices and exit with an actionable flag example.
- Filter physical devices separately from emulators/simulators, exclude unauthorized/offline
  devices, and check ABI/OS against the app. Do not take the first entry or a generic `booted`
  alias when multiple simulators exist. Match running Android emulators to their AVD names.
- Never bake in a model, runtime version, serial, or UDID from the starter author's machine.
  A project's preferred device can differ from another project's without changing committed JSON.

Inventory uses [Android SDK tools](https://developer.android.com/tools/adb) and
[Xcode command-line tools](https://developer.apple.com/documentation/xcode/xcode-command-line-tool-reference).
Bootstrap is a checklist because native project templates, identifiers, signing, and toolchain
versions vary. Add a reproducible generator only when those choices have been made for that app.
