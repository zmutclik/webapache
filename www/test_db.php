<?php
// Hanya aktif jika APP_DEBUG=1, karena membuka detail host & error koneksi database
if (getenv('APP_DEBUG') !== '1') {
    http_response_code(404);
    exit;
}
require_once __DIR__ . '/config.php';
try {
    $link = mysqli_connect($db_host, $db_user, $db_pass, $db_name);
    if (!$link) {
        throw new Exception("Error: Unable to connect to MySQL. " . mysqli_connect_error(), mysqli_connect_errno());
    }
    echo "Success: A proper connection to MySQL was made! The docker database is great." . PHP_EOL;
    echo "Host information: " . mysqli_get_host_info($link) . PHP_EOL;
    mysqli_close($link);
} catch (Exception $e) {
    echo $e->getMessage() . PHP_EOL;
    echo "<br>";
    echo "Debugging errno: " . $e->getCode() . PHP_EOL;
}
