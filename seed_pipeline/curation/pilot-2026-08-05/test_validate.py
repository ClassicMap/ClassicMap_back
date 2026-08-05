from __future__ import annotations

import importlib.util
import io
import json
import tempfile
import unittest
from pathlib import Path
from types import ModuleType

MODULE_PATH = Path(__file__).with_name("validate.py")


def load_validator() -> ModuleType:
    spec = importlib.util.spec_from_file_location("comparison_pilot_validator", MODULE_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError("검증기 모듈을 불러올 수 없습니다.")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


validator = load_validator()


class ComparisonPilotValidationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.base = Path(__file__).parent
        self.candidates = validator.read_jsonl(self.base / "candidates.jsonl")
        self.templates = validator.read_jsonl(self.base / "prewarm-template.jsonl")

    def test_repository_artifacts_are_valid(self) -> None:
        validator.validate_candidates(self.candidates)
        validator.validate_prewarm_template(self.candidates, self.templates)

    def test_database_ids_are_rejected(self) -> None:
        changed = json.loads(json.dumps(self.candidates))
        changed[0]["credits"][0]["artistId"] = 1
        with self.assertRaisesRegex(validator.ValidationError, "데이터베이스 ID"):
            validator.validate_candidates(changed)

    def test_rendered_manifest_uses_post_load_ids(self) -> None:
        id_rows = [
            {"candidateKey": row["candidateKey"], "performanceId": index}
            for index, row in enumerate(self.templates, start=1)
        ]
        output = io.StringIO()
        validator.render_prewarm(self.templates, id_rows, output)
        rendered = [json.loads(line) for line in output.getvalue().splitlines()]
        self.assertEqual(len(rendered), len(self.templates))
        self.assertEqual(rendered[0]["performanceId"], 1)
        self.assertEqual(set(rendered[0]), {"performanceId", "videoId", "start", "end"})

    def test_read_jsonl_rejects_non_object(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "invalid.jsonl"
            path.write_text("[]\n", encoding="utf-8")
            with self.assertRaisesRegex(validator.ValidationError, "JSON 객체"):
                validator.read_jsonl(path)


if __name__ == "__main__":
    unittest.main()
