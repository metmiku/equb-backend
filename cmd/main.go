package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/jackc/pgx/v5"
	"github.com/joho/godotenv"
	db "github.com/metmiku/equb-backend/cmd/sqlc"
)

func main() {
	err := godotenv.Load()

	ctx := context.Background()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	connection, err := pgx.Connect(ctx, os.Getenv("DATABASE_URL"))
	if err != nil {
		panic(err)
	}
	defer connection.Close(ctx)

	User := db.New(connection)

	allUsers, err := User.GetUsers(ctx)

	if err != nil {
		log.Fatal(err)
	}

	for _, user := range allUsers {
		fmt.Println(user)
	}
}
