package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/dustin/go-wikiparse"
	"github.com/jackc/pgx/v4"
)

const (
	DB_DSN    = "host=localhost port=5432 dbname=pta user=pta_user password=secret sslmode=disable"
	STR_LIMIT = 127
)

func main() {
	p, err := wikiparse.NewParser(os.Stdin)
	if err != nil {
		log.Fatalf("Error setting up parser")
	}

	ctx := context.Background()

	con, err := pgx.Connect(ctx, DB_DSN)
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}
	defer con.Close(ctx)

	for err == nil {
		var page *wikiparse.Page
		page, err = p.Next()
		if err != nil {
			fmt.Errorf("failed parse wiki page: ", err)
			continue
		}

		fmt.Println(page.Title)
		fmt.Println(page.Revisions[0].Text)

		var title string

		if len(page.Title) >= STR_LIMIT {
			title = string([]rune(page.Title)[:127])
		} else {
			title = page.Title
		}

		res, err := con.Exec(ctx, "INSERT INTO articles (title, content) VALUES ($1, $2)", title, page.Revisions[0].Text)
		if err != nil {
			log.Fatalf("failed to insert article: %v", err)
		}

		log.Printf("inserted %d rows", res.RowsAffected())
	}
}
