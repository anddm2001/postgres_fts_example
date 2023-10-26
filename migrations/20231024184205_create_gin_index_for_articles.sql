-- +goose Up
CREATE INDEX IF NOT EXISTS idx_fts_articles ON articles
  USING gin(make_tsvector(title, content));

-- +goose Down
DROP INDEX idx_fts_articles;