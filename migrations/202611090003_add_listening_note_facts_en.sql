-- 듣기 노트 사실 태그(facts, 「베를린 필」「반복 없이」 같은 짧은 말 목록)의 영어. 비어 있으면 화면은 한국어를 쓴다.
ALTER TABLE performance_listening_notes
    ADD COLUMN facts_en JSON NULL;
