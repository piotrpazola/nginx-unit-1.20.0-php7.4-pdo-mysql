#!/bin/bash
# building nginx unit php7.4 module in nginx/unit:1.24.0-minimal
# based on: Packaging Custom Modules - https://unit.nginx.org/howto/modules/
# Piotr Pazola <piotr@webtrip.pl>
export UNITTMP=$(mktemp -d -p /tmp -t unit.XXXXXX)
mkdir -p $UNITTMP/unit-php7.4/DEBIAN
cd $UNITTMP
curl -O https://unit.nginx.org/download/unit-1.24.0.tar.gz
tar xzf unit-1.24.0.tar.gz
cd unit-1.24.0
./configure --prefix=/usr --state=/var/lib/unit --control=unix:/var/run/control.unit.sock --pid=/var/run/unit.pid --log=/var/log/unit.log --tmp=/var/tmp --user=unit --group=unit --openssl --libdir=/usr/lib/x86_64-linux-gnu --cc-opt='-g -O2 -fdebug-prefix-map=/unit=. -specs=/usr/share/dpkg/no-pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --modules=/usr/lib/unit/modules
./configure php --module=php7.4 --config=php-config
make php7.4
mkdir -p $UNITTMP/unit-php7.4/usr/lib/unit/modules
mv build/php7.4.unit.so $UNITTMP/unit-php7.4/usr/lib/unit/modules
echo 'Package: unit-php7.4
Version: 1.24.0
Architecture: amd64
Depends: php7.4-common, libphp7.4-embed
Maintainer: Piotr Pazola <piotr@webtrip.pl>
Description: PHP 7.4 language module for NGINX Unit 1.24.0' > $UNITTMP/unit-php7.4/DEBIAN/control
dpkg-deb -b $UNITTMP/unit-php7.4
cp $UNITTMP/unit-php7.4.deb /unit-php7.4.deb
