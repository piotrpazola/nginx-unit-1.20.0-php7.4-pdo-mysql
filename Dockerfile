FROM nginx/unit:1.20.0-minimal as builder
LABEL maintainer="Piotr Pazola piotr@webtrip.pl"
RUN apt update && apt install -y ca-certificates apt-transport-https \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list \
    && apt update && apt install -y php7.4 php7.4-mysql php7.4-dev libphp7.4-embed
COPY ./build.sh /build.sh
RUN /build.sh

FROM nginx/unit:1.20.0-minimal
LABEL maintainer="Piotr Pazola piotr@webtrip.pl"
RUN apt update && apt install -y ca-certificates apt-transport-https \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list \
    && apt update && apt install -y php7.4-common php7.4-mysql libphp7.4-embed
COPY --from=builder /unit-php7.4.deb /unit-php7.4.deb
RUN dpkg -i /unit-php7.4.deb \
    && apt purge -y ca-certificates apt-transport-https apache2 && apt clean autoclean \
    && apt autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/ && rm -rf /unit-php7.4.deb
