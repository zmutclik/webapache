FROM ubuntu
LABEL maintainer="Fahrudin Hariadi<fahrudin.hariadi@gmail.com>"
ARG PHPVERSION
RUN apt update
RUN apt -y upgrade
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && echo Asia/Jakarta > /etc/timezone
RUN apt -y install iproute2 nano iputils-ping lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common gcc make autoconf libc-dev pkg-config logrotate
RUN add-apt-repository --yes ppa:ondrej/php
RUN apt-get -y install apache2
RUN apt -y install mariadb-client
RUN apt -y install php$PHPVERSION php$PHPVERSION-mysql libapache2-mod-php$PHPVERSION php$PHPVERSION-cli php$PHPVERSION-cgi php$PHPVERSION-gd zip php$PHPVERSION-xml
RUN a2enmod rewrite
RUN phpenmod mbstring
RUN apt -y install php$PHPVERSION-dev
RUN apt -y install php$PHPVERSION-mbstring php$PHPVERSION-intl
RUN apt -y install libmcrypt-dev
RUN sed -i '6i\Listen 8080' /etc/apache2/ports.conf
RUN echo '#!/bin/bash\n\n\nsource /etc/apache2/envvars\n#tail -F /var/log/apache2/* &\nexec apache2 -D FOREGROUND' > /boot/start.sh
RUN chmod +x /boot/start.sh
RUN rm /var/www/html/index.html
RUN apt -y install imagemagick imagemagick-doc
RUN apt -y install php$PHPVERSION-Imagick
RUN apt -y install php$PHPVERSION-intl
RUN apt -y install git composer
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
EXPOSE 80
WORKDIR /var/www/html/
CMD ["/boot/start.sh"]
