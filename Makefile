
BUILD = docker compose -f srcs/docker-compose.yml  up   --build -d


build_and_up_with_detach: make_dir
	$(BUILD)

make_dir:
	mkdir -p /home/sjoao/data/mariadb_data
	mkdir -p /home/sjoao/data/wordpress_data

build: make_dir
	@docker compose -f srcs/docker-compose.yml  build

up:
	@docker compose -f srcs/docker-compose.yml  up -d

down:
	@docker compose -f srcs/docker-compose.yml  down

dup: down up

help:
	@echo "make build_and_up_with_detach - Build and run the containers in detached mode"
	@echo "make up - Run the containers in detached mode"
	@echo "make down - Stop and remove the containers"
	@echo "make build - Build the images for the containers"
	@echo "make logs - View logs of the containers"
	@echo "make ps - List the running containers"
	@echo "make restart - Restart the containers"
	@echo "make clean - Stop and remove containers, networks, volumes, and images created by 'up'"
	@echo "make remove - Remove data directories for mariadb and wordpress"
	@echo "make fclean - Clean up everything including data directories and prune Docker system"
	@echo "make re - Rebuild and run the containers after cleaning up"

networks:
	@docker network ls

restart:
	@docker compose -f srcs/docker-compose.yml  restart

ps:
	@docker compose -f srcs/docker-compose.yml  ps

logs:
	@docker compose -f srcs/docker-compose.yml  logs -f

clean:
	@docker compose -f srcs/docker-compose.yml  down --remove-orphans --volumes 

remove:
	sudo rm -rf /home/sjoao/data/mariadb_data/* /home/sjoao/data/wordpress_data/* 

fclean: clean remove
	docker system prune -f

re: fclean 	build_and_up_with_detach
