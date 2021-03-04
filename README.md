# A simple dockerized SheepIt render farm client

This is a [fork](https://github.com/AGSPhoenix/sheepit-docker) of [AGSPhoenix's sheepit-docker container](https://hub.docker.com/r/agsphoenix/sheepit-docker/) with some additional improvements and updated instructions.
Also being able to run without root while still being open source as opposed to [mydigitalwalk's sheepit-docker container](https://hub.docker.com/r/mydigitalwalk/sheepit-docker).

## Instructions
Insert your username and password/public-key in-place off `<user>` and `<pass>`.

It is recommended to use a public key instead of your actual sheepit account password for authentication.  
Public keys can be created in your [Sheepit account page](https://www.sheepit-renderfarm.com/account.php?mode=profile) under the Keys tab.  
A possible comment of your choice for the public key could be 'docker'.  

The name that is shown for your machine in your profile on SheepIt is dictated by the hostname that is set with `--hostname`, default being `sheepit-docker`.  
It is only visible to you, moderators and administrators.  

### Simple run example

```
docker run -d \
 --name "sheepit" \
 --hostname "sheepit-docker" \
 --init \
 -e user_name=<user> \
 -e user_password=<pass> \
 dacoolx/sheepit-docker:latest
```

### Fully featured run example

```
docker run -d \
 --name "sheepit" \
 --hostname "sheepit-docker" \
 --init \
 -e user_name=<user> \
 -e user_password=<pass> \
 -e user_UID=1000 \
 -e user_GID=1000 \
 -e extra_opt="-rendertime 120" \
 --cpuset-cpus="0-3" \
 --cpuset-shares=128 \
 dacoolx/sheepit-docker:latest
```

### Extra sheepit parameters

You can pass additional parameters to sheepit such as for example `-verbose` with the help of the `extra_opt` environment variable like so `-e extra_opt="--verbose"`.

### User and Group IDs

If you want to change the UID and GID of the running user you can use the `user_UID` and `user_GID` environment variables respectivly.

### CPU cores and Priority

To configure how and which cpu cores to use it is recommended to use `--cpuset-cpus=""` and `--cpuset-shares="".`

Things to note for `--cpuset-cpus`:
Cores are indexed from 0 onwards, if you have for example a CPU with 8 cores, the cores would go from 0 up to 7.
If only half the cores should be used in this example, a proper way would be to supply a range like so `--cpuset-cpus="0-3"`.
`--cpuset-cpus="0-3"` being equivalent to `--cpuset-cpus="0,1,2,3"`.


Things to note for `--cpuset-shares`:
With CPU shares you can effectively set the priority on the CPU for the affected Docker container.
The default value of shares is 1024. For example if two processes would want to use 100% of CPU resources,
with the same priority (same amount of shares and no other processes) both would get 50%.
For another example: Should one of them have 512 shares, half of the default, The split would be 33% to 66%, not 50% to 50% when using the full CPU capacity.
This only takes effect if two processes compete for CPU time, if only one process is CPU-heavy and there is still capacity to spare,
all remaining CPU time will be automatically allotted to the single process regardless of priority


The author personally uses `--cpuset-shares=128`.
On a host with multiple running services it is good courtesy and common sense to use sheepit only with enough CPU time and/or CPU cores to spare.
On a system with an idle load of 15% with only occasional heavy CPU loads, running sheepit with lower priority makes sense,
or to reserve certain cores by allotting a lot of shares on those containers using those limited set of cores.
Should the host machine be required for CPU-heavy loads that would compete with sheepit,
the best approach is to pause sheepit for the time being in order to not skew off to far from the approximated performance expected by the sheepit scheduler.
Or to restart sheepit to reset the power percentage calculation, taking advantage of mismatches is highly frowned upon.


## Todo and other possible future features

#### Short term:  
Add docker-compose example  
Add and clarify memory options  

#### Long term:  
Shell script that handles signals, graceful shutdown/restarts, automatic updates, crash/freeze recovery  
Base image on alpine (Very very hard, possibly need to compile many deps ourselves)  


## Extra bits
[Docker Hub page](https://hub.docker.com/r/dacoolx/sheepit-docker)  
[GitHub page](https://github.com/DaCoolX/sheepit-docker/)  
[Original Fork Docker Hub page](https://hub.docker.com/r/agsphoenix/sheepit-docker/)  
[Original Fork GitHub page](https://github.com/AGSPhoenix/sheepit-docker)  

[SheepIt client GitHub repo](https://github.com/laurent-clouet/sheepit-client)  
[SheepIt site](https://www.sheepit-renderfarm.com/)  
