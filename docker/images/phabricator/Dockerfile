FROM php:5.6.8-fpm
MAINTAINER Matt Glaman <nmd.matt@gmail.com>
# Install PHP stuff
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
    && docker-php-ext-install mcrypt pdo_mysql mysql mysqli mbstring opcache soap bcmath pcntl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN pecl install apcu-4.0.10 \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

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
# There is not a way to mark container dependencies, so we do this for now as a quick hack.
CMD echo "Sleeping for database container" && sleep 10s \
  && bin/config set mysql.host $PHABRICATOR_MYSQL_HOST \
  && bin/config set mysql.user $PHABRICATOR_MYSQL_USER \
  && bin/config set mysql.pass $PHABRICATOR_MYSQL_PASS \
  && bin/config set phabricator.base-uri $PHABRICATOR_URI \
  && bin/storage --force upgrade \
  && bin/phd start --force \
  && php-fpm --allow-to-run-as-root
