# learn_python_using_examples

A production-grade Python learning repository focused on building real-world, maintainable software step by step.

**Goals**
- Learn Python the way production teams use it: clean code, types, testing, and tooling.
- Practice OOP and SOLID through incremental modules and capstones.
- Build confidence with asyncio, resilient clients, and modern patterns.
- Develop habits around linting, formatting, typing, CI, and pre-commit.
- Keep everything repeatable and automated.

**Repository Structure**
- `src/lpe/common/`
Shared building blocks: logging, errors, config, retry/backoff, time, DI helpers.
- `src/lpe/modules/`
Self-contained learning modules with `README.md` and a `src/` playground.
- `src/lpe/capstones/`
Larger “mini-products” that combine multiple modules.
- `tests/`
Smoke tests and module checks.

**Getting Started**
- Python 3.10+ (macOS/Linux recommended; Windows via WSL works well).

Create and activate a venv:
```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -U pip
```

Install dev dependencies (source of truth is `pyproject.toml`):
```bash
pip install -e ".[dev]"
```

**Common Commands**
```bash
python -m pytest
python -m ruff check .
python -m ruff format .
python -m mypy src
```

**Run a Module**
- Read the module guide: `src/lpe/modules/00_basics/README.md`
- Implement examples in: `src/lpe/modules/00_basics/src/`
- Add tests under: `tests/modules/`

**Create a New Module**
```bash
python scripts/new_module.py 13_cli_basics
```

This generates:
- `src/lpe/modules/13_cli_basics/README.md`
- `src/lpe/modules/13_cli_basics/src/.gitkeep`

**Development Notes**
- Use the project venv so plugins like `pytest-asyncio` are loaded.
- Run tests with `python -m pytest` to avoid PATH/plugin surprises.

**Contributing**
See `CONTRIBUTING.md`.
