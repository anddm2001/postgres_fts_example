-- +goose Up
CREATE INDEX IF NOT EXISTS idx_fts_articles1 ON articles1
  USING rum(make_tsvector(title, content));

-- +goose Down
DROP INDEX idx_fts_articles1;