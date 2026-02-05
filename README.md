learn_python_using_examples


# learn_python_using_examples

A production-grade Python learning repository focused on building real-world, maintainable software—step by step—from fundamentals to advanced topics like OOP, SOLID, design patterns, asyncio concurrency, resilience, observability, and clean architecture.

---

## Goals

- Learn **Python the way production teams use it** (clean code, types, testing, tooling).
- Practice **OOP + SOLID** through incremental modules and capstones.
- Build confidence with **asyncio**, resilient API clients, and modern patterns.
- Develop habits around **linting, formatting, typing, CI, and pre-commit**.
- Keep everything **repeatable, automated, and scalable** for future projects.

---

## Repository Structure

> The repo follows the recommended **`src/` layout**.


**Development**
- Use the project venv to ensure plugins like `pytest-asyncio` are loaded.
- Run tests with `python -m pytest`.



### Key Directories

- **`src/lpe/common/`**
  - Shared, production-style building blocks: structured logging, typed errors, configuration, retry/backoff, time abstractions, lightweight DI helpers.
- **`src/lpe/modules/`**
  - Each module is self-contained with its own `README.md` and `src/` playground area.
- **`src/lpe/capstones/`**
  - Larger “mini-products” that combine multiple modules into cohesive applications or libraries.
- **`tests/`**
  - Smoke tests + module checks to keep the repo always runnable.

---

## Getting Started

### Prerequisites
- Python **3.10+**
- macOS/Linux recommended (Windows works with WSL)

### Create and activate venv

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -U pip

Install dependencies

Recommended (source of truth in pyproject.toml):

pip install -e ".[dev]"


Alternative (requirements files):

pip install -r requirements-dev.txt

Development

Use the project venv to ensure plugins like pytest-asyncio are loaded.

Run tests with python -m pytest.

Common commands
# Tests
python -m pytest

# Lint
python -m ruff check .

# Format
python -m ruff format .

# Type check
python -m mypy src

One-command local checks
./scripts/run_all.sh

How to Run Modules

Each module has:

src/lpe/modules/<module_name>/README.md

src/lpe/modules/<module_name>/src/ (code area)

Typical workflow

Open the module README:

open src/lpe/modules/00_basics/README.md


Implement examples inside:

src/lpe/modules/00_basics/src/


Add or update tests:

tests/modules/


Run:

python -m pytest
python -m ruff check .
python -m mypy src

Create a new module folder
python scripts/new_module.py 13_cli_basics


This generates:

src/lpe/modules/13_cli_basics/README.md

src/lpe/modules/13_cli_basics/src/.gitkeep

Conventions
Code style

Formatting and linting are enforced by Ruff

Standard line length: 100

Prefer composition over inheritance, except when modeling true “is-a” relationships.

Typing

Use type hints everywhere (strict mypy).

Prefer Protocol for abstractions and clean contracts.

Errors

Prefer explicit domain errors and predictable failure paths.

When building APIs later, use a Problem Details shape (application/problem+json) for consistent error responses.

Logging

Use structured logging (planned via lpe.common.logging).

Log events with context (correlation IDs, inputs, durations).

Avoid logging secrets.

Testing

Use pytest + pytest-asyncio for async workflows.

Tests should be deterministic and fast.

New code should include tests where meaningful.

Contribution Workflow
Branching

main is always releasable.

Create feature branches:

git checkout -b feat/<short-topic>

Before committing (recommended)
pre-commit run -a
python -m pytest
python -m mypy src

Commit style

Use clear, conventional-ish messages:

feat: add async retry example

fix: handle timeout in http client

docs: expand module 02_solid notes

chore: update tooling versions

Pull Requests

Keep PRs small and focused.

Include:

Summary of changes

How to test

Any follow-ups / TODOs

CI

GitHub Actions runs on every push/PR:

Ruff lint

Ruff format check

Mypy type checking

Pytest

If CI fails, fix locally using:

./scripts/run_all.sh

Roadmap

See:

docs/roadmap.md

License

See LICENSE.

Acknowledgements

This repository is designed as a practical, production-grade learning path to build scalable Python systems using modern engineering practices.
