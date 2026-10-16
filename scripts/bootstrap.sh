#!/usr/bin/env bash
# Prints a setup checklist only. No tool downloads, project generation, or file changes.
# TODO: add an app-specific generator only after its identifiers/toolchain are selected.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
[[ $# == 1 ]] || { echo 'Usage: ./scripts/bootstrap.sh android|ios|macos' >&2; exit 2; }
case "$1" in
    android) cat <<'TEXT'
Android bootstrap checklist (no changes made):
1. Select app/package ID, min/target SDK, and required device ABIs in docs/PROJECT.md.
2. Select a compatible Studio/JDK/Gradle/AGP/Kotlin/Compose/NDK set in docs/TOOLCHAIN.md.
3. Create a minimal Kotlin/Compose project with Android Studio or a maintained generator.
4. Add the small Rust crate + pinned UniFFI bindgen; package matching .so and Kotlin bindings.
5. Wire build/test/install/run scripts; prove a real release call and typed error, including R8/JNA.
TEXT
        ;;
    ios|macos) cat <<'TEXT'
Apple bootstrap checklist (no changes made):
1. Activate selected iOS/iPadOS/macOS targets; choose bundle ID and deployment targets.
2. Select Xcode/Swift and a local signing team, if installing on a device.
3. Create a minimal SwiftUI project with Xcode or a maintained, versioned project generator.
4. Add Rust + matching UniFFI Swift bindings; package distinct device/simulator slices as needed.
5. Wire scripts with the real project/scheme/destinations; verify the boundary on each active target.
TEXT
        ;;
    --help|-h) echo 'Usage: ./scripts/bootstrap.sh android|ios|macos (prints a checklist; no scaffolding)'; exit 0 ;;
    *) echo 'Usage: ./scripts/bootstrap.sh android|ios|macos' >&2; exit 2 ;;
esac
printf '\nNext: docs/TOOLCHAIN.md and docs/ORGANIZERMD.md. Update scripts and organizermd.json together.\n'
