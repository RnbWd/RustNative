#!/usr/bin/env bash
# Only known repo-local build output. Never clean app data, keys, SDKs, global caches, or devices.
# TODO: adjust this allowlist if the actual native project's output paths differ.
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
apply=0
case "${1:-}" in
    '') ;;
    --apply) apply=1 ;;
    --help|-h) echo 'Usage: ./scripts/clean.sh [--apply] (preview by default)'; exit 0 ;;
    *) echo 'Usage: ./scripts/clean.sh [--apply]' >&2; exit 2 ;;
esac
[[ $# -le 1 ]] || { echo 'Usage: ./scripts/clean.sh [--apply]' >&2; exit 2; }
outputs=(build target android/build android/app/build apple/build apple/.build apple/DerivedData)

# Validate every path before deleting anything. Reject symlinks in all components,
# including android/ or apple/, so an output path cannot traverse outside this repo.
for relative in "${outputs[@]}"; do
    path="$RUSTNATIVE_ROOT"
    IFS=/ read -r -a components <<< "$relative"
    for component in "${components[@]}"; do
        path="$path/$component"
        [[ ! -L "$path" ]] || { printf 'Refusing symlink in cleanup path: %s\n' "$path" >&2; exit 2; }
    done
done
for relative in "${outputs[@]}"; do
    path="$RUSTNATIVE_ROOT/$relative"
    [[ -e "$path" ]] || continue
    [[ -d "$path" ]] || { printf 'Skipping non-directory: %s\n' "$relative"; continue; }
    if ((apply)); then
        printf 'Removing %s\n' "$relative"
        rm -rf -- "$path"
    else
        printf 'Would remove %s\n' "$relative"
    fi
done
if ((apply)); then echo 'Build-output cleanup complete.'; else echo 'Preview only. Use --apply to remove listed build output; stop builds first.'; fi
