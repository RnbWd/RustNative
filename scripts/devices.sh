#!/usr/bin/env bash
# Inventory only: never boot, install, pair, or select a device.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"

android_tool() {
    local name="$1" relative="$2" sdk
    if command -v "$name" >/dev/null 2>&1; then command -v "$name"; return; fi
    for sdk in "${ANDROID_HOME:-}" "${ANDROID_SDK_ROOT:-}"; do
        if [[ -n "$sdk" && -x "$sdk/$relative" ]]; then printf '%s\n' "$sdk/$relative"; return; fi
    done
    printf 'Missing %s: add it to PATH or set ANDROID_HOME to the SDK.\n' "$name" >&2
    return 2
}

case "${1:-}" in
    android)
        [[ $# == 1 ]] || { echo 'Usage: ./scripts/devices.sh android|ios' >&2; exit 2; }
        status=0
        printf 'Connected Android devices (check authorization and state):\n'
        if tool="$(android_tool adb platform-tools/adb)"; then "$tool" devices -l || status=1; else status=2; fi
        printf '\nAvailable Android virtual devices:\n'
        if tool="$(android_tool emulator emulator/emulator)"; then "$tool" -list-avds || status=1; else status=2; fi
        exit "$status"
        ;;
    ios)
        [[ $# == 1 ]] || { echo 'Usage: ./scripts/devices.sh android|ios' >&2; exit 2; }
        command -v xcrun >/dev/null 2>&1 || { echo 'Apple inventory requires macOS with the selected Xcode tools.' >&2; exit 2; }
        printf 'Available Apple simulators (all installed runtimes; filter for the app when launching):\n'
        xcrun simctl list devices available
        printf '\nPhysical Apple devices:\n'
        exec xcrun devicectl list devices
        ;;
    --help|-h) echo 'Usage: ./scripts/devices.sh android|ios (lists only; does not boot or install)' ;;
    *) echo 'Usage: ./scripts/devices.sh android|ios' >&2; exit 2 ;;
esac
