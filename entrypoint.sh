#!/bin/bash

export SERVERNAME=${SERVERNAME}
export DOCUMENTROOT=${DOCUMENTROOT}
export DB_HOST=${DB_HOST}
export DB_APPUSER=${DB_USER}
export DB_APPPASS=${DB_PASS}
export DB_NAME=${DB_NAME}

source /etc/apache2/envvars
/etc/init.d/cron start

# Jalankan command utama container (misalnya, Apache atau PHP-FPM).
# `exec "$@"` memastikan bahwa sinyal (seperti CTRL+C) yang dikirim ke container
# akan diteruskan ke proses utama, sehingga container bisa mati dengan bersih.
exec "$@"