-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION make_tsvector(title TEXT, content TEXT)
   RETURNS tsvector AS $$
BEGIN
  RETURN (setweight(to_tsvector('english', title),'A') || setweight(to_tsvector('english', content), 'B'));
END; -- FUNCTION END
$$ LANGUAGE 'plpgsql' IMMUTABLE;
-- +goose StatementEnd

-- +goose Down
