
BUILD = docker compose -f srcs/docker-compose.yml up --build -d 

RUN = docker compose run --rm

TEST = $(RUN) test

build:
	mkdir -p /home/sjoao/data/mariadb
	mkdir -p /home/sjoao/data/wordpress
	$(BUILD)


clean:
	docker compose -f srcs/docker-compose.yml  down --volumes #--remove-orphans

remove:
	sudo rm -rf /home/sjoao/data/mariadb /home/sjoao/data/wordpress

fclean: clean remove
	docker system prune -f

re: fclean build

#titan ferra cai por terra
# nao sao deuses reles seres
# para vcs eu sou a morte
# dilaceradndo cortando o seu
