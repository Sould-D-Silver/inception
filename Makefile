


BUILD = docker compose -f srcs/docker-compose.yml up --build -d 

RUN = docker compose run --rm

TEST = $(RUN) test

build:
	mkdir -p /home/sjoao/data/mariadb
	mkdir -p /home/sjoao/data/wordpress
	$(BUILD)

clean:
	docker compose -f srcs/docker-compose.yml  down ##--volumes --remove-orphans

fclean: clean
	docker system prune -f

re: fclean build