#! /bin/bash

#Stop on errors
set -e -x

echo "Killing ALL docker containers!!!"
for i in $(docker ps -a | awk '{print $1}' | grep -v "CONTAINER ID"); do docker kill ${i} | true; done

echo "Removing ALL docker containers!!!"
for i in $(docker ps -a | awk '{print $1}' | grep -v "CONTAINER ID"); do docker rm -f ${i} | true; done

echo "Removing all docker volumes!!!"
for i in $(docker volume ls | cut -f6 -d" " | grep -v "VOLUME NAME"); do docker volume rm ${i} | true; done

echo "Nuking ALL docker images"
for i in $(docker image ls | awk '{print $3}' | grep -v "IMAGE"); do docker image rm $i --force; done

docker ps -a
docker image ls
docker volume ls
