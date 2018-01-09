FROM debian:latest
MAINTAINER Raph Crypto <raph17.crypto@gmail.com>
LABEL version="1.0"
LABEL description="Local MyEtherWallet distribution"
RUN apt-get -y update && apt-get --yes --force-yes install \
apache2 \ 
wget \
unzip \
apt-utils \
&& wget https://github.com/kvhnuke/etherwallet/releases/download/v3.11.2/etherwallet-v3.11.2.zip \ 
&& unzip etherwallet* && rm etherwallet*.zip && rm -rf /var/www/html && mkdir /var/www/html && cp -r  etherwall*/* /var/www/html/ && chown www-data:www-data -R /var/www/html && chmod -R 555  /var/www/html && a2enmod ssl && a2ensite default-ssl


CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]

