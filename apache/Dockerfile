FROM ubuntu:20.04
LABEL maintainer="anil.natha@jpl.nasa.gov"
LABEL version="0.0.1"

ENV TZ US/Pacific
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -yq apache2 vim \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

###########################################################################
# Apache configuration

RUN a2enmod proxy
RUN a2enmod proxy_ajp
RUN a2enmod proxy_http
RUN a2enmod rewrite
RUN a2enmod include
RUN a2enmod ssl

RUN mkdir -p /var/www/portal-legacy

COPY ./etc/apache2/sites-available/001-portal-legacy.conf /etc/apache2/sites-available/
RUN a2dissite 000-default 
RUN a2ensite 001-portal-legacy

###########################################################################
# Default command to run container

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND", "-k", "start"]