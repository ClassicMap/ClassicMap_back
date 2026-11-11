SELECT p.id, p.composer_id, c.name AS cname, c.english_name AS cname_en, c.tier, p.title, p.title_en, p.work_type, p.opus_number, p.catalogue_system, p.catalogue_number, p.genre, p.form_key, p.notable, p.origin, p.editor_locked,
    (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id=p.id AND pp.parent_part_id IS NULL AND pp.editorial_status IN ('EDITOR_REVIEWED','PUBLISHED')) AS parts,
    (SELECT COUNT(*) FROM piece_parts pp WHERE pp.linked_piece_id=p.id) AS linked_from,
    (SELECT COUNT(*) FROM performance_sectors s WHERE s.piece_id=p.id) AS sec,
    (SELECT COUNT(*) FROM composer_highlights h WHERE h.piece_id=p.id AND h.status='PUBLISHED') AS hl,
    (SELECT GROUP_CONCAT(i.external_id) FROM piece_identifiers i WHERE i.piece_id=p.id AND i.namespace='musicbrainz_work') AS mbids,
    p.created_at
  FROM pieces p JOIN composers c ON c.id=p.composer_id
  WHERE p.hidden_reason IS NULL
