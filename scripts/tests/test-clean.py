"""Protect cleanup boundaries using disposable repositories, never the real checkout."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

SCRIPTS = Path(__file__).resolve().parents[1]


class CleanTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="rustnative clean ")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name) / "repo"
        (self.root / "scripts").mkdir(parents=True)
        for name in ("clean.sh", "_common.sh"):
            shutil.copy2(SCRIPTS / name, self.root / "scripts" / name)

    def write(self, relative):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text("keep or remove as declared")
        return path

    def clean(self, *arguments):
        return subprocess.run(
            ["bash", str(self.root / "scripts/clean.sh"), *arguments],
            cwd=self.temporary.name, text=True, capture_output=True,
        )

    def test_preview_and_apply_preserve_sources_keys_and_app_data(self):
        artifacts = [self.write(p) for p in (
            "build/a", "target/a", "android/app/build/a", "apple/DerivedData/a",
        )]
        preserved = [self.write(p) for p in (
            "core/src/lib.rs", "android/app/src/a", ".env.local", "signing/key.jks",
            "data/user.db", ".git/config", ".gradle/cache", "build-notes/README.md",
        )]
        preview = self.clean()
        self.assertEqual(preview.returncode, 0, preview.stderr)
        self.assertTrue(all(p.exists() for p in artifacts + preserved))
        applied = self.clean("--apply")
        self.assertEqual(applied.returncode, 0, applied.stderr)
        self.assertTrue(all(not p.exists() for p in artifacts))
        self.assertTrue(all(p.exists() for p in preserved))

    def test_symlink_ancestor_rejected_before_any_deletion(self):
        outside = Path(self.temporary.name) / "outside"
        (outside / "app/build").mkdir(parents=True)
        sentinel = outside / "app/build/private-data"
        sentinel.write_text("must survive")
        (self.root / "android").symlink_to(outside, target_is_directory=True)
        earlier_output = self.write("build/keep-until-validation-passes")
        result = self.clean("--apply")
        self.assertEqual(result.returncode, 2, result.stderr)
        self.assertIn("symlink", result.stderr)
        self.assertTrue(sentinel.exists())
        self.assertTrue(earlier_output.exists())


if __name__ == "__main__":
    unittest.main()
