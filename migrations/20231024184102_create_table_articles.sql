-- +goose Up
CREATE TABLE IF NOT EXISTS articles(id serial primary key, title varchar(128), content text);

-- +goose Down
DROP TABLE IF EXISTS articles;