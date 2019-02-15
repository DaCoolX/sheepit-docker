# A simple dockerized SheepIt render farm client

This is a [fork](https://github.com/AGSPhoenix/sheepit-docker) of [AGSPhoenix's sheepit-docker container](https://hub.docker.com/r/agsphoenix/sheepit-docker/) with some addtional improvments and updated instructions

## Instructions
Insert your username and password in-place off \<user\> and \<pass\>.

It is recommended to use a public key instead of your actual sheepit account password for authentication.  
Public keys can be created in your [Sheepit account page](https://www.sheepit-renderfarm.com/account.php?mode=profile) under the Keys tab.  
A possible comment of your choice for the public key could be 'docker'.  

```
docker run -d \
 --name "sheepit" \
 --hostname "sheepit-docker" \
 --init \
 -e user_name=<user> \
 -e user_password=<pass> \
 dacoolx/sheepit-docker:latest
```

You can also specify the `cpu` variable to override autodetection; like `-e cpu=4`.

## Extra bits
[Docker Hub page](https://hub.docker.com/r/dacoolx/sheepit-docker)  
[GitHub page](https://github.com/DaCoolX/sheepit-docker/)  
[Upstream Docker Hub page](https://hub.docker.com/r/agsphoenix/sheepit-docker/)  
[Upstream GitHub page](https://github.com/AGSPhoenix/sheepit-docker)  

[SheepIt client GitHub repo](https://github.com/laurent-clouet/sheepit-client)  
[SheepIt site](https://www.sheepit-renderfarm.com/)  
