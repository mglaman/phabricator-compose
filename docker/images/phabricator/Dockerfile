FROM php:5.6.8-fpm
MAINTAINER Matt Glaman <nmd.matt@gmail.com>
# Install PHP stuff
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        php5-apcu \
    && docker-php-ext-install mcrypt pdo_mysql mysql mysqli mbstring opcache soap bcmath pcntl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Install Pygments
RUN apt-get update && apt-get install -y python-pip \
  && pip install pygments

# Install stuff for Phab
RUN apt-get update && apt-get install -y git sendmail
WORKDIR /var/www/html
RUN git clone https://github.com/phacility/libphutil.git \
  && git clone https://github.com/phacility/arcanist.git \
  && git clone https://github.com/phacility/phabricator.git \
  && mkdir -p /var/repo
WORKDIR /var/www/html/phabricator
CMD bin/config set mysql.host $PHABRICATOR_MYSQL_HOST \
  && bin/config set mysql.user $PHABRICATOR_MYSQL_USER \
  && bin/config set mysql.pass $PHABRICATOR_MYSQL_PASS \
  && bin/config set phabricator.base-uri $PHABRICATOR_URI \
  && bin/storage --force upgrade \
  && bin/phd start \
  && php-fpm --allow-to-run-as-root
