#!/usr/bin/env python3
"""
Creates a new learning module folder under:
src/lpe/modules/{NN_name}/README.md and src/ placeholder

Usage:
  python scripts/new_module.py 13_topic_name
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: python scripts/new_module.py 13_topic_name")
        return 2

    raw = sys.argv[1].strip()
    if not re.fullmatch(r"\d{2}_[a-z0-9_]+", raw):
        print(
            "Invalid module name. Expected format: 13_topic_name (two digits + underscore + snake_case)."
        )
        return 2

    root = Path(__file__).resolve().parents[1]
    mod_dir = root / "src" / "lpe" / "modules" / raw
    (mod_dir / "src").mkdir(parents=True, exist_ok=True)

    readme = mod_dir / "README.md"
    if not readme.exists():
        readme.write_text(f"# {raw}\n\n## Goals\n\n## Exercises\n\n## Notes\n", encoding="utf-8")

    (mod_dir / "src" / ".gitkeep").touch(exist_ok=True)

    print(f"Created/verified: {mod_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
