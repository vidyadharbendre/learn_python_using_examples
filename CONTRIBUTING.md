# Contributing

Thanks for contributing. This repo is intentionally small and strict to keep quality high.

**Quick Start**
- Create and activate a venv.
- Install dev deps with `pip install -e ".[dev]"`.
- Run `pre-commit install`.

**Development Workflow**
- `main` is always releasable.
- Create a feature branch: `git checkout -b feat/<short-topic>`.
- Keep changes small and focused.

**Before You Commit**
```bash
pre-commit run -a
python -m pytest
python -m mypy src
```

**Code Style**
- Formatting and linting are enforced by Ruff.
- Keep functions small and readable.
- Prefer composition over inheritance unless modeling a true “is-a” relationship.

**Typing**
- Use type hints consistently.
- Prefer `Protocol` for abstractions and clean contracts.
- Keep mypy strict for library code.

**Testing**
- Tests should be deterministic and fast.
- Add tests when behavior changes or a bug is fixed.

**Commit Messages**
Use clear, conventional-ish messages:
- `feat: add async retry example`
- `fix: handle timeout in http client`
- `docs: expand module 02_solid notes`
- `chore: update tooling versions`

**Pull Requests**
Include:
- A short summary of changes.
- Testing performed.
