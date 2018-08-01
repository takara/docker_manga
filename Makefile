NAME=manga
VERSION=v1.0
DOCKER_RUN_OPTIONS= \
	--privileged \
	--net=docker-lan \
	--ip=192.168.100.104 \
	-p 3307:3306 \
	-v `pwd`/comics:/var/www/comics \
	-v `pwd`/src:/var/www/server

include docker.mk
