from __future__ import annotations

import importlib.util
from pathlib import Path


def load_new_module():
    root = Path(__file__).resolve().parents[2]
    script_path = root / "scripts" / "new_module.py"
    spec = importlib.util.spec_from_file_location("new_module", script_path)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_new_module_usage(monkeypatch, capsys):
    module = load_new_module()
    monkeypatch.setattr(module, "__file__", str(Path("/tmp") / "scripts" / "new_module.py"))
    monkeypatch.setattr(module.sys, "argv", ["new_module.py"])

    assert module.main() == 2
    out = capsys.readouterr().out
    assert "Usage: python scripts/new_module.py" in out


def test_new_module_invalid_name(monkeypatch, capsys):
    module = load_new_module()
    monkeypatch.setattr(module, "__file__", str(Path("/tmp") / "scripts" / "new_module.py"))
    monkeypatch.setattr(module.sys, "argv", ["new_module.py", "bad-name"])

    assert module.main() == 2
    out = capsys.readouterr().out
    assert "Invalid module name" in out


def test_new_module_creates_scaffold(tmp_path, monkeypatch, capsys):
    module = load_new_module()
    fake_script = tmp_path / "scripts" / "new_module.py"
    fake_script.parent.mkdir(parents=True, exist_ok=True)
    fake_script.write_text("# placeholder", encoding="utf-8")

    monkeypatch.setattr(module, "__file__", str(fake_script))
    monkeypatch.setattr(module.sys, "argv", ["new_module.py", "13_topic_name"])

    assert module.main() == 0

    mod_dir = tmp_path / "src" / "lpe" / "modules" / "13_topic_name"
    assert (mod_dir / "README.md").exists()
    assert (mod_dir / "src" / ".gitkeep").exists()

    readme = (mod_dir / "README.md").read_text(encoding="utf-8")
    assert readme.startswith("# 13_topic_name")

    out = capsys.readouterr().out
    assert "Created/verified" in out
