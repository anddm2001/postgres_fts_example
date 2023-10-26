-- +goose Up
CREATE EXTENSION rum;

-- +goose Down
DROP EXTENSION rum;