FROM ubuntu
LABEL maintainer="Fahrudin Hariadi<fahrudin.hariadi@gmail.com>"
ARG SERVERNAME
ARG PHPVERSION
RUN apt update
RUN apt -y upgrade
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && echo Asia/Jakarta > /etc/timezone
RUN apt -y install iproute2 \
    nano \
    iputils-ping \
    lsb-release \
    gnupg2 \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    gcc \
    make \
    autoconf \
    libc-dev \
    pkg-config \
    logrotate \
    cron \
    iputils-ping \
    traceroute \
    gh \
    git \
    composer \
    zip
RUN add-apt-repository --yes ppa:ondrej/php
RUN apt-get -y install apache2
RUN echo "ServerName $SERVERNAME" | tee -a /etc/apache2/apache2.conf >/dev/null
RUN apt -y install mariadb-client
RUN apt -y install php$PHPVERSION \
    php$PHPVERSION-mysql \
    libapache2-mod-php$PHPVERSION \
    php$PHPVERSION-cli \
    php$PHPVERSION-cgi \
    php$PHPVERSION-gd \
    php$PHPVERSION-xml \
    php$PHPVERSION-dev \
    php$PHPVERSION-mbstring \
    php$PHPVERSION-intl \
    php$PHPVERSION-curl \
    php$PHPVERSION-zip
RUN a2enmod rewrite
RUN phpenmod mbstring
RUN apt -y install libmcrypt-dev
RUN rm /var/www/html/index.html
# RUN apt -y install imagemagick imagemagick-doc
# RUN apt -y install php$PHPVERSION-Imagick
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
EXPOSE 80
WORKDIR /var/www/html/
