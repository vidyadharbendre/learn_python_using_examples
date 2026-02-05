.PHONY: help venv install install-dev fmt lint type test cov precommit

help:
	@echo "Targets: venv install install-dev fmt lint type test cov precommit"

venv:
	python3 -m venv .venv
	. .venv/bin/activate && python -m pip install -U pip

install:
	. .venv/bin/activate && pip install -e .

install-dev:
	. .venv/bin/activate && pip install -e ".[dev]"

fmt:
	. .venv/bin/activate && ruff format .

lint:
	. .venv/bin/activate && ruff check .

type:
	. .venv/bin/activate && mypy src

test:
	. .venv/bin/activate && python -m pytest

cov:
	. .venv/bin/activate && coverage run -m pytest && coverage report -m

precommit:
	. .venv/bin/activate && pre-commit install && pre-commit run -a
