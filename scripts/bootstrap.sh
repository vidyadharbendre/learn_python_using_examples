#!/usr/bin/env bash
set -euo pipefail

# If you run this inside the repo, it will scaffold in-place.
# If you pass a name, it will scaffold into ./<name>.
REPO_NAME="${1:-.}"

if [[ "${REPO_NAME}" == "." ]]; then
  ROOT="$(pwd)"
else
  ROOT="$(pwd)/${REPO_NAME}"
  mkdir -p "$ROOT"
fi

# ---------- top-level files ----------
touch "$ROOT/README.md" \
      "$ROOT/LICENSE" \
      "$ROOT/CONTRIBUTING.md" \
      "$ROOT/CODE_OF_CONDUCT.md" \
      "$ROOT/SECURITY.md" \
      "$ROOT/CHANGELOG.md" \
      "$ROOT/Makefile" \
      "$ROOT/.gitignore" \
      "$ROOT/.editorconfig" \
      "$ROOT/.env.example" \
      "$ROOT/pyproject.toml" \
      "$ROOT/ruff.toml" \
      "$ROOT/mypy.ini" \
      "$ROOT/.pre-commit-config.yaml"

# ---------- docs ----------
mkdir -p "$ROOT/docs/style-guides" "$ROOT/docs/reference"
touch "$ROOT/docs/README.md" \
      "$ROOT/docs/mkdocs.yml" \
      "$ROOT/docs/index.md" \
      "$ROOT/docs/roadmap.md" \
      "$ROOT/docs/style-guides/python.md" \
      "$ROOT/docs/style-guides/testing.md" \
      "$ROOT/docs/style-guides/logging.md" \
      "$ROOT/docs/style-guides/security.md" \
      "$ROOT/docs/style-guides/architecture.md" \
      "$ROOT/docs/reference/problem_json.md" \
      "$ROOT/docs/reference/http_retries.md" \
      "$ROOT/docs/reference/async_patterns.md"

# ---------- scripts ----------
mkdir -p "$ROOT/scripts"
cat > "$ROOT/scripts/run_all.sh" <<'EOR'
#!/usr/bin/env bash
set -euo pipefail
python -m pytest -q
python -m ruff check .
python -m mypy src
EOR

cat > "$ROOT/scripts/ci_local.sh" <<'EOR'
#!/usr/bin/env bash
set -euo pipefail
./scripts/run_all.sh
EOR

cat > "$ROOT/scripts/new_module.py" <<'EOR'
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
        print("Invalid module name. Expected format: 13_topic_name (two digits + underscore + snake_case).")
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
EOR

chmod +x "$ROOT/scripts/"*.sh "$ROOT/scripts/new_module.py" || true

# ---------- src package ----------
mkdir -p "$ROOT/src/lpe/common" "$ROOT/src/lpe/modules" "$ROOT/src/lpe/capstones"
cat > "$ROOT/src/lpe/__init__.py" <<'EOR'
__all__ = ["common"]
EOR
touch "$ROOT/src/lpe/common/__init__.py"

# Common scaffolds (placeholders)
touch "$ROOT/src/lpe/common/logging.py" \
      "$ROOT/src/lpe/common/errors.py" \
      "$ROOT/src/lpe/common/config.py" \
      "$ROOT/src/lpe/common/typing.py" \
      "$ROOT/src/lpe/common/time.py" \
      "$ROOT/src/lpe/common/retry.py" \
      "$ROOT/src/lpe/common/di.py"

# ---------- modules ----------
MODULES=(
  "00_basics"
  "01_oop_foundations"
  "02_solid"
  "03_testing"
  "04_pydantic_models"
  "05_design_patterns"
  "06_asyncio_concurrency"
  "07_api_clients_resilience"
  "08_fastapi_service"
  "09_data_ingestion_pipeline"
  "10_storage_caching"
  "11_observability"
  "12_clean_architecture"
)

for m in "${MODULES[@]}"; do
  mkdir -p "$ROOT/src/lpe/modules/$m/src"
  cat > "$ROOT/src/lpe/modules/$m/README.md" <<EOR
# ${m}

## Goals

## Exercises

## Notes
EOR
  touch "$ROOT/src/lpe/modules/$m/src/.gitkeep"
done

# ---------- capstones ----------
touch "$ROOT/src/lpe/capstones/README.md"
CAPSTONES=(
  "01_cli_taskrunner"
  "02_async_api_client"
  "03_fastapi_service"
  "04_async_worker"
  "05_plugin_arch"
  "06_ingestion_pipeline"
  "07_pubsub_sim"
  "08_cache_storage"
  "09_observability_stack"
  "10_clean_arch_app"
)
for c in "${CAPSTONES[@]}"; do
  mkdir -p "$ROOT/src/lpe/capstones/$c"
  touch "$ROOT/src/lpe/capstones/$c/.gitkeep"
done

# ---------- tests ----------
mkdir -p "$ROOT/tests/modules"
cat > "$ROOT/tests/README.md" <<'EOR'
# Tests

This folder contains repo-wide tests (smoke, tooling, and module-specific checks).
EOR
touch "$ROOT/tests/conftest.py"
cat > "$ROOT/tests/test_smoke_imports.py" <<'EOR'
def test_import_package():
    import lpe  # noqa: F401
EOR
touch "$ROOT/tests/modules/test_00_basics.py"

# ---------- .github ----------
mkdir -p "$ROOT/.github/workflows" "$ROOT/.github/ISSUE_TEMPLATE"
touch "$ROOT/.github/workflows/ci.yml" \
      "$ROOT/.github/workflows/release.yml" \
      "$ROOT/.github/PULL_REQUEST_TEMPLATE.md" \
      "$ROOT/.github/ISSUE_TEMPLATE/bug.yml" \
      "$ROOT/.github/ISSUE_TEMPLATE/feature.yml"

echo "✅ Scaffold created at: $ROOT"
