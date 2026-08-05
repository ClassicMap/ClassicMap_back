from classicmap_seed.models import DataOrigin, ExistingFieldState


def can_apply_seed_value(existing: ExistingFieldState | None) -> bool:
    """수동 또는 잠긴 기존 필드를 자동 시드가 덮어쓰지 못하게 합니다."""
    if existing is None:
        return True
    return existing.origin is not DataOrigin.MANUAL and not existing.editor_locked
