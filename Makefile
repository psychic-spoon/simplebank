.PHONY: createdb dropdb postgres migrateup migratedown sqlc

createdb: 
	docker exec -it bankpostgres createdb --username=root --owner=root simple_bank

dropdb: 
	docker exec -it bankpostgres dropdb simple_bank

postgres: 
	docker run --name bankpostgres -p 7432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=admin -d postgres:16-alpine 

migrateup: 
	migrate -path db/migration --database "postgresql://root:admin@localhost:7432/simple_bank?sslmode=disable" -verbose up

migratedown: 
	migrate -path db/migration --database "postgresql://root:admin@localhost:7432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...