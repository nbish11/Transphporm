FROM php:7.3-cli
COPY --from=composer:latest /usr/bin/composer usr/local/bin/composer
COPY . /transphporm
WORKDIR /transphporm

ENV XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003 start_with_request=yes idekey=docker log_level=3 log=/dev/stdout"
ENV XDEBUG_MODE="develop,debug,coverage,profile"

RUN apt-get -y update
RUN apt-get -y install git
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN composer install --prefer-dist

EXPOSE 9003

CMD ./vendor/bin/phpunit
