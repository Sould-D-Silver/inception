
BUILD = docker compose -f srcs/docker-compose.yml  up   --build -d

RUN = docker compose -f srcs/docker-compose.yml  run --rm



build_and_up_with_detach: make_dir
	$(BUILD)

make_dir:
	mkdir -p /home/sjoao/data/mariadb_data
	mkdir -p /home/sjoao/data/wordpress_data

up:
	docker compose -f srcs/docker-compose.yml  up -d

down:
	docker compose -f srcs/docker-compose.yml  down

help:
	@echo "make build_and_up_with_detach - Build and run the containers in detached mode"
	@echo "make up - Run the containers in detached mode"
	@echo "make down - Stop and remove the containers"
	@echo "make logs - View logs of the containers"
	@echo "make clean - Stop and remove containers, networks, volumes, and images created by 'up'"
	@echo "make remove - Remove data directories for mariadb and wordpress"
	@echo "make fclean - Clean up everything including data directories and prune Docker system"
	@echo "make re - Rebuild and run the containers after cleaning up"

networks:
	@docker network ls

ps:
	@docker compose -f srcs/docker-compose.yml  ps

logs:
	docker compose -f srcs/docker-compose.yml  logs -f

clean:
	docker compose -f srcs/docker-compose.yml  down --remove-orphans --volumes 

remove:
	sudo rm -rf /home/sjoao/data

fclean: clean remove
	docker system prune -f

re: fclean 	build_and_up_with_detach

#titan ferra cai por terra
# nao sao deuses reles seres
# para vcs eu sou a morte
# dilaceradndo cortando o seu
