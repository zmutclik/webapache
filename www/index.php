<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>LAMP STACK</title>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css'>
</head>

<body>
    <section class='hero is-medium is-info is-bold'>
        <div class='hero-body'>
            <div class='container has-text-centered'>
                <h1 class='title'>LAMP STACK</h1>
                <h2 class='subtitle'>Your local development environment</h2>
            </div>
        </div>
    </section>
    <section class='section'>
        <div class='container'>
            <div class='columns'>
                <div class='column'>
                    <h3 class='title is-3 has-text-centered'>Environment</h3>
                    <hr>
                    <div class='content'>
                        <ul>
                            <li><?= apache_get_version(); ?></li>
                            <li>PHP<?= phpversion(); ?></li>
                            <li><?php
                                require_once __DIR__ . '/config.php';
                                try {
                                    $link = @mysqli_connect($db_host, $db_user, $db_pass, $db_name);
                                    if (mysqli_connect_errno()) {
                                        throw new Exception('MySQL connection failed: ' . mysqli_connect_error());
                                    } else {
                                        printf('Server [%s@%s] -> %s', $db_user, $db_host, mysqli_get_server_info($link));
                                    }
                                    mysqli_close($link);
                                } catch (Exception $e) {
                                    echo $e->getMessage();
                                }
                                ?></li>
                        </ul>
                    </div>
                </div>
                <div class='column'>
                    <h3 class='title is-3 has-text-centered'>Quick Links</h3>
                    <hr>
                    <div class='content'>
                        <ul>
                            <li><b><?php echo date('Y-m-d H:i:s'); ?></b></li>
                            <li><a href='http://<?php echo $_SERVER['HTTP_HOST']; ?>/phpinfo.php'>phpinfo()</a></li>
                            <li><a href='http://<?php echo $_SERVER['HTTP_HOST']; ?>/test_db.php'>Test DB Connection</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>

</html>