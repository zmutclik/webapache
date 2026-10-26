<?php
// Hanya aktif jika APP_DEBUG=1, karena phpinfo() membuka seluruh konfigurasi & env (termasuk password DB)
if (getenv('APP_DEBUG') !== '1') {
    http_response_code(404);
    exit;
}
phpinfo();
