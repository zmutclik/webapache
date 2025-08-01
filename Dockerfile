FROM ubuntu
LABEL maintainer="Fahrudin Hariadi<fahrudin.hariadi@gmail.com>"
ARG SERVERNAME
ARG PHPVERSION
ENV SERVERNAME=${SERVERNAME}
ENV PHPVERSION=${PHPVERSION}
ENV DB_HOST=127.0.0.1
ENV DB_USER=root
ENV DB_PASS=password
ENV DB_NAME=db
RUN apt update && apt -y upgrade \
    && apt -y install iproute2 \
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
    imagemagick imagemagick-doc \
    zip \
    && ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && echo Asia/Jakarta > /etc/timezone \
    && add-apt-repository --yes ppa:ondrej/php && apt-get -y install apache2 \
    && apt -y install php$PHPVERSION \
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
    php$PHPVERSION-zip \
    php$PHPVERSION-bcmath \
    php$PHPVERSION-xmlrpc \
    php$PHPVERSION-Imagick \
    mariadb-client \
    libmcrypt-dev \
    && a2enmod rewrite && phpenmod mbstring \
    && rm /var/www/html/index.html && sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf \
    && echo 'ServerName ${SERVERNAME}' | tee -a /etc/apache2/apache2.conf >/dev/null \
    &&  apt-get clean && rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /usr/local/bin/
COPY virtualhost.conf /etc/apache2/sites-available/000-default.conf
COPY ./www /var/www/html
RUN chmod +x /usr/local/bin/entrypoint.sh && chown -R www-data:www-data /var/www/html
EXPOSE 80
WORKDIR /var/www/html/
ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2", "-D", "FOREGROUND"]