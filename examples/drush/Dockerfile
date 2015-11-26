FROM drupal:latest

RUN apt-get update && apt-get install -y openssh-server

RUN curl -fSL https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar -o drush.phar \
	&& php drush.phar core-status \
	&& chmod +x drush.phar \
	&& mv drush.phar /usr/local/bin/drush \
	&& php /usr/local/bin/drush init
