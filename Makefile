ifeq ($(USER),root)
	VOLUME_PATH	:= /home/${SUDO_USER}/data
else
	VOLUME_PATH	:= /home/${USER}/data
endif

HOST_LINK	:= "127.0.0.1	donghyle.42.fr" > /etc/hosts

all:
	make prune
	make build

prune:
	chmod 666 /var/run/docker.sock
	mkdir -p $(VOLUME_PATH)
	mkdir -p $(VOLUME_PATH)/mariadb/
	mkdir -p $(VOLUME_PATH)/wordpress/
	echo $(HOST_LINK)

build:
	docker compose -f ./srcs/docker-compose.yml up --build -d

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes

fclean:
	make clean
	rm -rf $(VOLUME_PATH)

re:
	make fclean
	make all

.PHONY: all down clean fclean re
