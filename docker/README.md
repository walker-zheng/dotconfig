# Usage
```
docker daemon
	docker network create some-network
	docker volume create some-docker-certs-ca 
	docker volume create some-docker-certs-client
	docker run --privileged --name $USER-docker -d --network some-network --network-alias docker -e DOCKER_TLS_CERTDIR=/certs -v some-docker-certs-ca:/certs/ca -v some-docker-certs-client:/certs/client docker:dind
ubuntu-sshd
	docker build . -f Dockerfile -t ubuntu-sshd:v2 --build-arg UID=$UID --build-arg GROUPS=$GROUPS --build-arg USER=$USER
	docker run -d --rm --name $USER-ubuntu --network some-network -e DOCKER_TLS_CERTDIR=/certs -v some-docker-certs-client:/certs/client:ro -v ~:/root -v ~:/home/$USER -p 22222:22  -p 22223:80 -p 22224:8000  -p 22224:8000/udp --cap-add=SYS_PTRACE ubuntu-sshd:v4 /bin/bash -c "/usr/sbin/nginx;/usr/sbin/sshd -D" --memory 8G --memory-swap 8G
	ssh $USER@localhost -p 22222
	docker commit -m 'update' -a walker $USER-ubuntu ubuntu-sshd:v3

```

# config remote vscode-server
```
vscode remote ssh
	docker context create remote-server --docker "host=ssh://meiyang.zheng@10.97.32.205:22"
	vscode
		enter wsl
			docker context use: remote-server
		enter docker
			select docker
```
