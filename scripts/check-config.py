#!/usr/bin/env python3
"""Check OrganizerMD references and repo-local paths without invoking a native toolchain."""
import json
from pathlib import Path, PurePosixPath
import shlex
import sys

ROOT = Path(__file__).resolve().parent.parent


def project_path(value):
    path = PurePosixPath(value)
    if not value or path.is_absolute() or ".." in path.parts:
        raise ValueError(f"Path leaves the project: {value!r}")
    resolved = (ROOT / value).resolve()
    if not resolved.is_relative_to(ROOT):
        raise ValueError(f"Path resolves outside the project: {value!r}")
    return resolved


def indexed(entries, kind):
    result = {}
    for entry in entries:
        key = entry["id"]
        if not key or key in result:
            raise ValueError(f"Empty or duplicate {kind} id: {key!r}")
        result[key] = entry
    return result


def check():
    config = json.loads((ROOT / "organizermd.json").read_text())
    if config["version"] != 2:
        raise ValueError("Expected OrganizerMD configuration version 2")
    commands = indexed(config.get("commands", []), "command")
    apps = indexed(config.get("apps", []), "app")
    actions = indexed(config.get("actions", []), "action")
    for entry in commands.values():
        directory = project_path(entry.get("workingDirectory", "."))
        if not directory.is_dir():
            raise ValueError(f"Missing working directory: {directory}")
        if entry.get("purpose") not in (None, "build", "run", "install", "test"):
            raise ValueError(f"Unsupported purpose: {entry['id']}")
        parts = shlex.split(entry["command"])
        if not parts:
            raise ValueError(f"Empty command: {entry['id']}")
        if parts[0].startswith(("./scripts/", "scripts/")):
            script = project_path(str((directory / parts[0]).relative_to(ROOT)))
            if not script.is_file() or not script.stat().st_mode & 0o111:
                raise ValueError(f"Missing or non-executable script: {script}")
    for entry in apps.values():
        project_path(entry["path"])  # Built apps need not exist yet.
    if config.get("defaultApp") is not None and config["defaultApp"] not in apps:
        raise ValueError("Unknown defaultApp")
    for entry in actions.values():
        for target in [entry, *entry.get("options", [])]:
            keys = set(target) & {"command", "app", "file"}
            if len(keys) != 1:
                raise ValueError(f"Action needs exactly one target: {entry['id']}")
            kind = keys.pop()
            value = target[kind]
            if kind == "command" and value not in commands:
                raise ValueError(f"Unknown command: {value}")
            if kind == "app" and value not in apps:
                raise ValueError(f"Unknown app: {value}")
            if kind == "file" and not project_path(value).exists():
                raise ValueError(f"Missing action file: {value}")
    for key in ("include", "exclude"):
        for pattern in config.get("documents", {}).get(key, []):
            project_path(pattern.removeprefix("**/"))
    print(f"OrganizerMD: {len(actions)} actions, {len(commands)} commands; references and paths valid.")


if __name__ == "__main__":
    try:
        check()
    except (KeyError, TypeError, ValueError, OSError) as error:
        print(f"OrganizerMD check failed: {error}", file=sys.stderr)
        sys.exit(1)
