-- Add awards column to artists table
-- 형식: year:name|year:name (예: 2015:쇼팽 국제 피아노 콩쿠르 1위|2011:차이콥스키 국제 콩쿠르 3위)

ALTER TABLE artists
ADD COLUMN awards TEXT COMMENT '수상 경력 (형식: year:name|year:name)' AFTER style;
