NAME=manga
VERSION=v1.0
DOCKER_RUN_OPTIONS= \
	--privileged \
	-p 80:80 \
	-v `pwd`/comics:/var/www/comics \
	-v `pwd`/src:/var/www/server

include docker.mk
