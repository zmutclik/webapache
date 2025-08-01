#!/bin/bash

sed -i "s|${SERVERNAME}|${SERVERNAME}|g" /etc/apache2/apache2.conf
sed -i "s|${SERVERNAME}|${SERVERNAME}|g" /etc/apache2/sites-available/000-default.conf
sed -i "s|${DOCUMENTROOT}|${DOCUMENTROOT}|g" /etc/apache2/sites-available/000-default.conf

source /etc/apache2/envvars
/etc/init.d/cron start

# Jalankan command utama container (misalnya, Apache atau PHP-FPM).
# `exec "$@"` memastikan bahwa sinyal (seperti CTRL+C) yang dikirim ke container
# akan diteruskan ke proses utama, sehingga container bisa mati dengan bersih.
exec "$@"