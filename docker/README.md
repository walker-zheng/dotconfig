# Usage
```
docker build . -f Dockerfile -t ubuntu-sshd:v2 --build-arg UID=$UID --build-arg GROUPS=$GROUPS --build-arg USER=$USER
docker run -d --rm --name $USER-ubuntu -v ~:/root -v ~:/home/$USER -p 22222:22  -p 22223:80 -p 22224:8000 --cap-add=SYS_PTRACE ubuntu-sshd:v2 /bin/bash -c "/usr/sbin/nginx;/usr/sbin/sshd -D" --memory 8G --memory-swap 8G
ssh $USER@localhost -p 22222
docker commit -m 'update' -a walker $USER-ubuntu ubuntu-sshd:v3
```

# config remote vscode-server
```
docker context create remote-server --docker "host=ssh://$USER@10.97.32.205:22"
vscode
	enter wsl
		docker context use: remote-server
	enter docker
select docker
```