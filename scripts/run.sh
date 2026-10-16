#!/usr/bin/env bash
# TODO: choose target, build (unless --no-build), boot if needed, install, then launch.
# Validate --no-build artifact/configuration; report when freshness is not checked.
# Reuse only an unambiguous compatible device or a validated project-local preference.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
template_task './scripts/run.sh android|ios|macos emulator|simulator|device|desktop debug|release [--device ID] [--avd NAME] [--no-build]' \
    'Wire the project-specific launcher and a numbered device chooser; see docs/ORGANIZERMD.md.' "$@"
