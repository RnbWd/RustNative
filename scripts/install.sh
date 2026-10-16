#!/usr/bin/env bash
# TODO: validate an existing artifact, select a device, and install without clearing data.
# Preserve the installed signature; a signing mismatch must not trigger an uninstall.
# Installation does not build or launch. run.sh can compose build + install + launch.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
template_task './scripts/install.sh android|ios device|emulator|simulator debug|release [--device ID]' \
    'Wire artifact/signing validation and a compatible-device chooser; never take the first list entry.' "$@"
