#!/usr/bin/env bash
# Template checks work today. TODO: add focused core/native tests after scaffolding.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
if [[ "${1:-template}" == template ]]; then
    [[ $# -le 1 ]] || { echo 'Usage: ./scripts/test.sh template' >&2; exit 2; }
    cd "$RUSTNATIVE_ROOT"
    for script in scripts/*.sh; do bash -n "$script"; done
    python3 scripts/check-config.py
    python3 scripts/tests/test-clean.py
    exit 0
fi
# Core: cargo test/fmt/clippy with an appropriate package scope.
# Android: unit tests by default; connected tests require deliberate device selection.
# Apple: use the actual scheme/destination and selected targets only.
template_task './scripts/test.sh [template|core|android|android-device|ios|macos]' \
    'Wire focused checks here; device tests must choose a compatible target and preserve app data.' "$@"
