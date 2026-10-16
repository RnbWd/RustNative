#!/usr/bin/env bash
# Shared paths and the deliberately unfinished native-task response.
set -euo pipefail
RUSTNATIVE_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
readonly RUSTNATIVE_ROOT

template_task() {
    local usage="$1" next_step="$2"
    shift 2
    if [[ "${1:-}" == --help || "${1:-}" == -h ]]; then
        printf 'Usage: %s\n%s\n' "$usage" "$next_step"
        return 0
    fi
    printf 'Not configured: this starter has no native app yet.\n%s\n' "$next_step" >&2
    printf 'Implement this entry point and update organizermd.json; see scripts/README.md.\n' >&2
    return 2
}
