# WebApache - Docker LAMP Stack

Docker image LAMP stack (Linux, Apache, MariaDB, PHP) berbasis Debian yang siap pakai untuk pengembangan dan production. Image tersedia di Docker Hub: [zmutclik/webapache](https://hub.docker.com/repository/docker/zmutclik/webapache/general).

## Fitur

- ✅ **Debian Latest** sebagai base image
- ✅ **Apache 2** dengan `mod_rewrite` dan `AllowOverride All`
- ✅ **PHP** versi konfigurabel via build arg (`PHPVERSION`)
- ✅ **MariaDB Client** bawaan untuk koneksi database
- ✅ **Ekstensi PHP lengkap**: `mysql`, `gd`, `xml`, `mbstring`, `intl`, `curl`, `zip`, `bcmath`, `xmlrpc`, `Imagick`
- ✅ **Timezone** Asia/Jakarta (dapat disesuaikan di Dockerfile)
- ✅ **Virtual Host** dinamis dengan environment variables
- ✅ **Cron & Logrotate** built-in
- ✅ **Multi-stage compose**: dari minimal hingga full stack (MariaDB + Git Webhook)
- ✅ **NFS support** untuk persistent volumes

## Struktur Proyek

```
webapache/
├── Dockerfile                  # Build image Docker
├── docker-compose.yml          # Compose: build lokal dari Dockerfile
├── docker-compose_stack.yml    # Compose: pakai image dari Docker Hub + network
├── docker-compose_stack_full.yml # Compose: full stack (MariaDB + Git Webhook)
├── docker-compose_less.yml     # Compose: versi minimal (hardcoded, tanpa .env)
├── entrypoint.sh               # Entrypoint container (setup env & start service)
├── virtualhost.conf            # Konfigurasi Apache Virtual Host
├── build-image.sh              # Script build & push image ke Docker Hub
├── env.sample                  # Template environment variables
├── env.sh                      # Script generate .env dengan password acak
├── www/                        # Root direktori aplikasi web
│   ├── index.php               # Halaman utama (info environment & koneksi DB)
│   ├── config.php              # Konfigurasi koneksi database dari ENV
│   ├── test_db.php             # Halaman test koneksi database
│   └── phpinfo.php             # Halaman phpinfo()
└── README.md
```

## Prasyarat

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

### 1. Clone repository

```bash
git clone <url-repo> webapache && cd webapache
```

### 2. Buat file `.env`

Salin dari template dan sesuaikan nilainya:

```bash
cp env.sample .env
nano .env
```

Atau gunakan script `env.sh` untuk generate password acak otomatis:

```bash
chmod +x env.sh && ./env.sh
```

### 3. Pilih mode deployment

#### A. Mode Minimal (tanpa `.env`)

Gunakan `docker-compose_less.yml` untuk testing cepat dengan nilai hardcoded:

```bash
docker compose -f docker-compose_less.yml up -d
```

Buka http://localhost:8099

#### B. Mode Build Lokal

Build image dari Dockerfile lokal, cocok untuk development dan kustomisasi:

```bash
docker compose up -d
```

#### C. Mode Stack (pakai image Docker Hub)

Gunakan image yang sudah di-publish ke Docker Hub, cocok untuk production:

```bash
docker compose -f docker-compose_stack.yml up -d
```

#### D. Mode Full Stack (MariaDB + Git Webhook)

Stack lengkap dengan database MariaDB dan Git webhook untuk auto-deployment:

```bash
docker compose -f docker-compose_stack_full.yml up -d
```

## Environment Variables

| Variable | Deskripsi | Default |
|---|---|---|
| `CONTAINER_NAME` | Nama container | `example` |
| `HOSTNAME` | Hostname container | `example` |
| `APPS_PORT` | Port Apache (host) | `8099` |
| `DATA_PORT` | Port MariaDB (host) | `3399` |
| `HOOK_PORT` | Port Git Webhook (host) | `7000` |
| `SERVERNAME` | ServerName Apache | `example.com` |
| `DOCUMENTROOT` | DocumentRoot Apache | `/var/www/html` |
| `PHPVERSION` | Versi PHP (8.1, 8.2, 8.3, dsb) | `8.1` |
| `DB_HOST` | Host database | `mariadb` |
| `DB_ROOTPASSWORD` | Password root MariaDB | `password` |
| `DB_APPUSER` | User aplikasi database | `user` |
| `DB_APPPASS` | Password aplikasi database | `apppassword` |
| `DB_NAME` | Nama database | `db` |
| `DNS1` | DNS primer | `192.168.51.51` |
| `DNS2` | DNS sekunder | `192.168.88.1` |
| `NFS_ADDRESS` | Alamat NFS server | `192.168.88.75` |
| `NFS_APPS_PATH` | Path NFS untuk aplikasi | `:/volume1/dataconfig/test` |
| `NFS_DATA_PATH` | Path NFS untuk data MariaDB | `:/volume1/mysqldata/test` |
| `GIT_URL_SSH` | URL Git repo (SSH) | `git@github.com:your/repo.git` |
| `REPO_PATH` | Path repository di container | `/app/repository` |
| `BRANCH` | Branch untuk webhook | `main` |

## Build & Push Image Manual

Untuk build dan push image ke Docker Hub:

```bash
# Pastikan .env sudah ada dengan PHPVERSION yang diinginkan
chmod +x build-image.sh
./build-image.sh
```

Script akan:
1. Build image dengan `--no-cache`
2. Tag image `zmutclik/webapache:${PHPVERSION}`
3. Push ke Docker Hub

## Volume

| Volume | Deskripsi |
|---|---|
| `datawww` | Data aplikasi web (`/var/www/html`) |
| `data` | Data MariaDB (`/var/lib/mysql`) |
| `repository` | Repository Git (untuk webhook) |
| `secrets` | Secrets untuk webhook |
| `logs` | Log webhook |

> **Catatan**: Uncomment bagian `driver_opts` di docker-compose untuk mengaktifkan NFS mount.

## Network

Mode `docker-compose_stack.yml` dan `docker-compose_stack_full.yml` menggunakan custom network `net` untuk isolasi jaringan antar service.

## Aplikasi Web

Folder `www/` berisi contoh aplikasi PHP sederhana:

- **index.php** — Dashboard LAMP Stack yang menampilkan versi Apache, PHP, dan status koneksi database
- **config.php** — Membaca konfigurasi database dari environment variables
- **test_db.php** — Halaman untuk mengetes koneksi database
- **phpinfo.php** — Informasi lengkap konfigurasi PHP

## Docker Hub

Image tersedia di: [https://hub.docker.com/repository/docker/zmutclik/webapache/general](https://hub.docker.com/repository/docker/zmutclik/webapache/general)

```bash
docker pull zmutclik/webapache:8.3
docker pull zmutclik/webapache:8.2
docker pull zmutclik/webapache:8.1
```

## Lisensi

MIT License

## Maintainer

Fahrudin Hariadi — [fahrudin.hariadi@gmail.com](mailto:fahrudin.hariadi@gmail.com)
