from __future__ import annotations

import importlib.util
from pathlib import Path

import pytest


def load_inheritance_module():
    root = Path(__file__).resolve().parents[2]
    module_path = root / "src" / "learn" / "oops_concept" / "inheritance.py"
    spec = importlib.util.spec_from_file_location("inheritance", module_path)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_dog_inherits_animal():
    module = load_inheritance_module()
    dog = module.Dog("Buddy")

    assert dog.species == "Dog"
    assert dog.name == "Buddy"
    assert dog.make_sound() == "Woof!"


def test_animal_sound_unimplemented():
    module = load_inheritance_module()
    animal = module.Animal("Animal")

    with pytest.raises(NotImplementedError):
        animal.make_sound()
