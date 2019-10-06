FROM php:fpm-alpine

# Install nginx
RUN apk add nginx
RUN docker-php-ext-install mysqli

# Install Wordpress
ENV WORDPRESS_VERSION 5.2.3
ENV WORDPRESS_SHA1 5efd37148788f3b14b295b2a9bf48a1a467aa303

WORKDIR /usr/src/wordpress

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress

# Route NGINX logs to stdout/stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

# Set up config
COPY nginx/module.conf /etc/nginx/modules/wordpress.conf
COPY nginx/vhost.conf /etc/nginx/conf.d/wordpress.conf
COPY wp-config.php /usr/src/wordpress/wp-config.php

# Start server
CMD php-fpm -D \
  && nginx