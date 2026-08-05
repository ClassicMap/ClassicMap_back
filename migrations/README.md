# ClassicMap SQL migrations

운영 데이터베이스 변경은 이 디렉터리의 additive SQL migration으로만 수행합니다.

- 기존 `schema.sql`은 신규 로컬 데이터베이스 초기화 전용이며 migration으로 실행하지 않습니다.
- 적용된 migration은 수정하지 않고 후속 migration을 추가합니다.
- 기존 컬럼의 삭제, 이름 변경, 타입 축소는 국제 초기 시드 v1 범위에서 금지합니다.
- migration은 애플리케이션이 데이터베이스 연결 직후 실행하며, 실패하면 서버 시작을 중단합니다.
