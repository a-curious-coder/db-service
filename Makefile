include .env
export

.PHONY: all clean test up down logs test-admin test-app1 rebuild backup

all: up

clean:
	docker-compose down
	docker system prune -f

test:
	docker-compose run --rm app pytest

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker-compose logs -f

test-admin:
	docker exec -it db psql -U "$$DB_USER"

test-app1:
	docker exec -it db psql -U "$$APP1_USER" -d "$$APP1_DB"

rebuild:
	docker-compose up -d --build

backup:
	./backup.sh

