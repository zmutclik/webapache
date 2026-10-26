<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>LAMP STACK</title>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css' integrity='sha384-DCY3M8xLkMu6c9IKcKbe+jHKMjelnwC0p+SBaxfHxoBYZWdJF2X400UdBCgATtAB' crossorigin='anonymous'>
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
                        <ul><?php
                                require_once __DIR__ . '/config.php';
                                $debug = getenv('APP_DEBUG') === '1';
                            ?>
                            <?php if ($debug): ?>
                            <li><?= htmlspecialchars(apache_get_version()); ?></li>
                            <li>PHP<?= htmlspecialchars(phpversion()); ?></li>
                            <?php endif; ?>
                            <li>DB-HOST = <?= htmlspecialchars((string) $db_host); ?></li>
                            <li>DB-USER = <?= htmlspecialchars((string) $db_user); ?></li>
                            <li>DB-PASS = <?= $db_pass !== false && $db_pass !== '' ? '********' : '(kosong)'; ?></li>
                            <li>DB-NAME = <?= htmlspecialchars((string) $db_name); ?></li>
                            <li><?php
                                try {
                                    $link = @mysqli_connect($db_host, $db_user, $db_pass, $db_name);
                                    if (mysqli_connect_errno()) {
                                        throw new Exception('Database connection failed: ' . mysqli_connect_error());
                                    } else {
                                        echo $debug
                                            ? htmlspecialchars(sprintf('Server [%s@%s] -> %s', $db_user, $db_host, mysqli_get_server_info($link)))
                                            : 'Database connected';
                                    }
                                    mysqli_close($link);
                                } catch (Exception $e) {
                                    echo $debug ? htmlspecialchars($e->getMessage()) : 'Database connection failed';
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
                            <?php if ($debug): ?>
                            <li><a href='/phpinfo.php'>phpinfo()</a></li>
                            <li><a href='/test_db.php'>Test DB Connection</a></li>
                            <?php endif; ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>

</html>