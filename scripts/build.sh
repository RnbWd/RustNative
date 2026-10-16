#!/usr/bin/env bash
# TODO: generate matching Rust/bindings, then invoke this app's Gradle or Xcode build.
# Keep builds separate from booting, installing, signing for distribution, and launching.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
template_task './scripts/build.sh android|ios|macos debug|release [simulator|device]' \
    'Wire the selected target, configuration, SDK/ABI, and native project into this script.' "$@"
