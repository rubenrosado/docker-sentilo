# Docker Sentilo

This repository contains different Dockerfiles for deploy Sentilo from their sources in Docker. These dockers images have been prepared following the [official setup guide](https://sentilo.readthedocs.io/en/latest/setup.html).

**This is not an official repository.**
**These scripts is for testing purposal only, not for production environments.**

Tested with `Sentilo 1.9.0`.

## Requirements
GNU/Linux OS like Debian with docker and docker-compose installed.
> The project use the following ports:
> - 8080: Tomcat server with Sentilo webapp
> - 8081 and 7081: Sentilo rest services
> - 27017: MongoDB
> - 6379: Redis
> 
> If you don't want edit the scripts from this project, you need these ports free on your system.

## Usage
Simply download this project and execute the `script.sh` script and wait to finish.
When all the process is finished, you can access from [http://localhost:8080/sentilo-catalog-web](http://localhost:8080/sentilo-catalog-web) with `admin` user and `1234` password.

### Script info
This script follow these steps:

1. This script first build a docker image from `compiler` with Ubuntu 20.04, OpenJDK 8, Git and Maven for compile Sentilo from their sources.
This image replaces the localhost IP with the docker network names in the required properties files.
I use a docker because the project can't finish successfully with OpenJDK 11 or later and the latest versions of Debian cannot provides OpenJDK 8 from APT.
When the image is ready, the script create a docker container with a volume into `/tmp` directory with the compiled binaries.

2. Copies the webapp WAR into `sentilo-catalog-web` folder and creates a docker image with tomcat.

3. Copies the binaries and libraries into `sentilo-catalog-web` folder and creates a docker image with OpenJDK.

4. Creates the mongodb init script with `sentilo` user and password and testing data.

5. The last step runs the docker-compose with sentilo, mongodb and redis.
