include .env

LOCAL_BIN:=$(CURDIR)/bin

LOCAL_MIGRATION_DIR=$(MIGRATION_DIR)
LOCAL_MIGRATION_DSN="host=localhost port=$(PG_PORT) dbname=$(PG_DATABASE_NAME) user=$(PG_USER) password=$(PG_PASSWORD) sslmode=disable"

PATH_APP_WP=./bin/wiki_parser
PATH_APP_WP_WIN=./bin/wiki_parser.exe

PATH_SOURCE_WIKI_PARSER=./cmd/wiki_parser/main.go

build:
	sudo docker compose build --no-cache

run:
	sudo docker compose up -d

start:
	build run

stop:
	sudo docker compose down 

stat:
	sudo docker compose ps

install-deps:
	GOBIN=$(LOCAL_BIN) go install github.com/pressly/goose/v3/cmd/goose@v3.14.0

local-migration-status:
	goose -dir ${LOCAL_MIGRATION_DIR} postgres ${LOCAL_MIGRATION_DSN} status -v

local-migration-up:
	goose -dir ${LOCAL_MIGRATION_DIR} postgres ${LOCAL_MIGRATION_DSN} up -v

local-migration-down:
	goose -dir ${LOCAL_MIGRATION_DIR} postgres ${LOCAL_MIGRATION_DSN} down -v

build-lin:
	go mod download && CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o $(PATH_APP_WP) $(PATH_SOURCE_WIKI_PARSER)

build-win:
	go mod download && CGO_ENABLED=0 GOOS=windows go build -ldflags "-s -w" -o $(PATH_APP_WP_WIN) $(PATH_SOURCE_WIKI_PARSER)

build-mac:
	go mod download && CGO_ENABLED=0 GOOS=darwin go build -ldflags "-s -w" -o $(PATH_APP_WP) $(PATH_SOURCE_WIKI_PARSER)