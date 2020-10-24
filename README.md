# NGINX Unit 1.20.0 with PHP7.4 and the newest PDO MYSQL support

Source of Docker custom built of NGINX Unit with PHP7.4 and PDO MYSQL support based on nginx/unit:1.20.0-minimal official image.

Ready to use image on Docker Hub: https://hub.docker.com/r/piotrpazola/nginx-unit

NGINX Unit is available only with PHP 7.3 and older implementation of PDO MYSQL does not support newest authentication of MYSQL 8.0 from the image of nginx/unit:1.20.0-php7.3. (Oct 2020)

I've build the newest compilation of PHP 7.4 with embeded support of PHP for the NGINX Unit and newest PDO MYSQL module working well with MYSQL 8.0 without any authentication issues.

It's based on nginx/unit:1.20.0-minimal where module for Unit is built from sources of php7.4 and unit1.20.0 then the prepared package is copied to next stage of builiding in Dockerfile starting building on clean nginx/unit:1.20.0-minimal image. How to prepare custom modules for NGINX Unit is describe here: https://unit.nginx.org/howto/modules/ and my approach has been using it in the first stage.

I've tried to make the image the smallest as possible. It's just approx. 10 MB bigger than offcial NGINX Unit nginx/unit:1.20.0-php7.3 with PHP 7.3 and old PDO MYSQL support installed by apk from Debian 10 repository.

## Installation

Build from sources of Dockerfile and build.sh I've provided in the repository.

```bash
docker build -t nginx-unit:1.20.0-php7.4-pdo-mysql .
```

OR use ready docker image from https://hub.docker.com/r/piotrpazola/nginx-unit

```bash
docker pull piotrpazola/nginx-unit:1.20.0-php7.4-pdo-mysql
```

## Usage

FROM built image in local repository:

```Dockerfile
FROM nginx-unit:1.20.0-php7.4-pdo-mysql
COPY ./nginx-unit-config.json /docker-entrypoint.d/config.json
```

OR get ready to use image from remote repository on Docker Hub:

```Dockerfile
FROM piotrpazola/nginx-unit:1.20.0-php7.4-pdo-mysql
COPY ./nginx-unit-config.json /docker-entrypoint.d/config.json
```

## Contributing
Pull requests are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)
