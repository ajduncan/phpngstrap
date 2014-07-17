#!/bin/sh

# Update and upgrade
echo "Updating system..."
apt-get update > /dev/null 2>&1
echo "Upgrading system packages..."
apt-get -y upgrade > /dev/null 2>&1

# Install system dependencies.
echo "Installing system dependencies: git build-essential autoconf"
apt-get -y install git build-essential autoconf > /dev/null 2>&1

# Ugh, ubuntu 14.04 and bision 3.
echo "Fetching bison 2"
wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
echo "Installing bison 2"
dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
dpkg -i bison_2.7.1.dfsg-1_amd64.deb

# php deps
echo "Installing php dependencies."
apt-get -y install librecode-dev librecode0 libssl-dev re2c libxml2-dev recode libxml2-dev libpcre3-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev libmysqlclient-dev libt1-dev libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev unixodbc-dev freetds-dev libpspell-dev libsnmp-dev libtidy-dev libxslt1-dev libmcrypt-dev

# cleanup deps
echo "Cleaning up the mess."
ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

su vagrant
cd /home/vagrant

echo -e "Host git.php.net\n\tStrictHostKeyChecking no\n" >> /home/vagrant/.ssh/config

git clone https://git.php.net/repository/php-src.git
cd php-src
git branch phpng origin/phpng
git checkout phpng
./buildconf
./configure \
    --prefix=$HOME/tmp/usr \
    --with-config-file-path=$HOME/tmp/usr/etc \
    --enable-mbstring \
    --enable-zip \
    --enable-bcmath \
    --enable-pcntl \
    --enable-ftp \
    --enable-exif \
    --enable-calendar \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-wddx \
    --with-curl \
    --with-mcrypt \
    --with-iconv \
    --with-gmp \
    --with-pspell \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-freetype-dir=/usr \
    --with-t1lib=/usr \
    --enable-gd-native-ttf \
    --enable-gd-jis-conv \
    --with-openssl \
    --with-mysql=/usr \
    --with-pdo-mysql=/usr \
    --with-gettext=/usr \
    --with-zlib=/usr \
    --with-bz2=/usr \
    --with-recode=/usr \
    --with-mysqli=/usr/bin/mysql_config
make
# make test


