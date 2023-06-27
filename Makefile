all:
	make prune
	make build

prune:
	sudo srcs/prune.sh srcs/.env

build:
	sudo docker compose -f ./srcs/docker-compose.yml up --build -d

up:
	sudo docker compose -f ./srcs/docker-compose.yml up -d

down:
	sudo docker compose -f ./srcs/docker-compose.yml down

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes

fclean:
	make clean
	rm -rf $(VOLUME_PATH)

re:
	make fclean
	make all

.PHONY: all prune down clean fclean re
