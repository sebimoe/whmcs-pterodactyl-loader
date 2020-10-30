# whmcs-pterodactyl-php-fpm
PHP FPM 7.4 with ionCube - unzips WHMCS and Pterodactyl module on startup

Based on `sebian/php-fpm-ioncube` image - PHP-FPM 7.4 with ionCube loader and extensions required and recommended for WHMCS.

This image checks `/zips` directory for `whmcs-full.zip` and `pterodactyl-whmcs.zip` files, if any is present these are renamed to `whmcs-full.loaded.zip` and `pterodactyl-whmcs.loaded.zip` respectively and extracted to `/app`.

## Required input files

Input files in `/zips`:
 - `whmcs-full.zip` - (Required) File downloaded from WHMCS (originally e.g. whmcs_v80X_full.zip) - should contain directory `whmcs` containing all php files for WHMCS.
 - `pterodactyl-whmcs-master.zip` - (Optional) Archived repository of [SagnikSRHUSE/Pterodactyl-WHMCS](https://github.com/SagnikSRHUSE/Pterodactyl-WHMCS) (originally e.g. whmcs-master.zip) - should contain directory `pterodactyl` containing all php/tpl files for the module.

## Where the files are extracted, how to serve

Files are unzipped to and served from `/app/` (and `/app/modules/servers/` as appropriate). PHP-FPM socket is open at port 9000 on all interfaces. See [`sebian/php-fpm-ioncube`]() or base image [`bitnami/php-fpm`](https://hub.docker.com/r/bitnami/php-fpm) for other configuration options, and how to serve via nginx.

