FILE=./srcs/docker-compose.yml

up:
	sudo srcs/prune.sh srcs/.env
	sudo docker compose -f $(FILE) up --build -d

down:
	sudo docker compose -f $(FILE) down

start:
	sudo docker compose -f $(FILE) start

stop:
	sudo docker compose -f $(FILE) stop

clean:
	sudo docker compose -f $(FILE) down -v

fclean:
	make down
	make clean
	sudo docker compose -f $(FILE) down --rmi all
	sudo srcs/fclean.sh

re:
	make fclean
	make up

.PHONY : up start stop down clean fclean re
