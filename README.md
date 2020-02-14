# A simple dockerized SheepIt render farm client

This is a [fork](https://github.com/AGSPhoenix/sheepit-docker) of [AGSPhoenix's sheepit-docker container](https://hub.docker.com/r/agsphoenix/sheepit-docker/) with some additional improvements and updated instructions

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

## CPU cores and Priority

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


## Possible future features:
Signal handling (Seems very unlikely)  
Base image on alpine (Very hard, possibly need to compile many deps ourselves)  


## Extra bits
[Docker Hub page](https://hub.docker.com/r/dacoolx/sheepit-docker)  
[GitHub page](https://github.com/DaCoolX/sheepit-docker/)  
[Original Fork Docker Hub page](https://hub.docker.com/r/agsphoenix/sheepit-docker/)  
[Original Fork GitHub page](https://github.com/AGSPhoenix/sheepit-docker)  

[SheepIt client GitHub repo](https://github.com/laurent-clouet/sheepit-client)  
[SheepIt site](https://www.sheepit-renderfarm.com/)  
