


BUILD = docker compose -f srcs/docker-compose.yml up --build -d 

RUN = docker compose run --rm

TEST = $(RUN) test

build:
	$(BUILD)

clean:
	docker compose down --volumes --remove-orphans

fclean: clean
	docker system prune -f

re: fclean build