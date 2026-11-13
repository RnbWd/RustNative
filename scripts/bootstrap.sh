#!/usr/bin/env bash
# Prints a setup checklist. Takes no action on the host or project.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"

usage='Usage: ./scripts/bootstrap.sh [web|android|ios|ipados|macos] (prints a checklist)'
[[ $# -le 1 ]] || { echo "$usage" >&2; exit 2; }
if [[ $# -eq 0 ]]; then
    cat <<'TEXT'
Project setup checklist:
1. Choose the primary target and active targets in docs/PROJECT.md.
2. Define the first useful feature in docs/PRODUCT.md.
3. Run this script with an explicit target for its setup checklist.
TEXT
else
    case "$1" in
    web) cat <<'TEXT'
Web setup checklist:
1. Select web in docs/PROJECT.md and choose browser coverage for the first feature.
2. Use conventional web technologies. Add Rust/WASM or a server only if the feature needs it.
3. Verify the feature in a browser and document its real setup, build, and run commands.
TEXT
        ;;
    android) cat <<'TEXT'
Android setup checklist:
1. Select Android in docs/PROJECT.md, choose the app ID and ABIs, and use API 36 as the baseline.
2. Choose a compatible Studio/JDK/Gradle/AGP/Kotlin/Compose set and create the Compose project.
3. If using Rust through UniFFI, select compatible NDK tooling and matching libraries and bindings.
4. Build and run the feature on Android. Check release packaging when affected.
TEXT
        ;;
    ios|ipados|macos) cat <<'TEXT'
Apple setup checklist:
1. Select the Apple targets in docs/PROJECT.md and choose the bundle ID and deployment targets.
2. Use SwiftUI with AppKit where macOS needs it. Use local signing when the destination requires it.
3. If using Rust through UniFFI, build matching bindings and libraries for each destination.
4. Build and run the feature on the selected destinations. Check release packaging when affected.
TEXT
        ;;
    --help|-h) echo "$usage"; exit 0 ;;
    *) echo "$usage" >&2; exit 2 ;;
    esac
fi
printf '\nNext: docs/TOOLCHAIN.md and docs/ORGANIZERMD.md. Update scripts and organizermd.json together.\n'
