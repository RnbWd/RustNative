#!/usr/bin/env bash
# TODO: discover/filter available AVDs or simulators, choose, then boot without building.
# Accept --device ID / --avd NAME or project-local preferences, not a committed machine ID.
# Agent checks must clean up only sessions they started; a user's interactive launch may stay open.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
template_task './scripts/emulator.sh android|ios [--device ID] [--avd NAME]' \
    'Wire a compatible-target chooser and bounded boot wait; do not pin an emulator model or OS here.' "$@"
