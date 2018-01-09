# mylocal-etherwallet
Running a local safe copy of MyEtherWallet

Running a local version of myetherwallet.com is the best option to stay secure.
I decided today to make a docker image for allowing anyone to run locally its own secured version of myetherwallet.

What is needed ?
 - A docker installation (mac, windows or linux)
 - The Dockerfile present in this repository
 
 As myetherwallet is dealing with real funds, you don't want to run a version of a wallet found on internet. That's why I won't offer you a built image, just the tools necessary to build and run your own.
 
 Let me explain each lines of my Dockerfile
 
```
#let's begin with a fresh new Debian installation
FROM debian:latest
#That's me !
MAINTAINER Raph Crypto <raph17.crypto@gmail.com>
#My version number
LABEL version="1.0"
#A little description
LABEL description="Local MyEtherWallet distribution"
#update current installation, then install APACHE webserver, wget and unzip tools
#then we download latest myetherwallet github package and unzip it in apache DocumentRoot
#finally we activate SSL default website
RUN apt-get -y update && apt-get --yes --force-yes install \
apache2 \
wget \
unzip \
apt-utils \
&& wget https://github.com/kvhnuke/etherwallet/releases/download/v3.11.2/etherwallet-v3.11.2.zip \
&& unzip etherwallet* && rm etherwallet*.zip && rm -rf /var/www/html && mkdir /var/www/html && cp -r  etherwall*/* /var/www/html/ && chown www-data:www-data -R /var/www\
/html && chmod -R 555  /var/www/html && a2enmod ssl && a2ensite default-ssl


CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
```

In order to buid this docker image you need to type in your terminal (inside the directory where Dockerfile is)
```
docker build -t my-local-ether-wallet .
```
Then you can launch your fresh new myetherwallet image with
```
docker run -d -p 4443:443 my-local-ether-wallet
```

Finally open your browser and go to : https://localhost:4443

The SSL certificate used is self signed so you might encounter an error in your browser.
Don't worry, this is safe.

You can now use your own myetherwallet very quickly without any fear that it might be compromised


Where can I download required Docker application ?
Docker for Windows 10 Enterprise : https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe
Docker for other (lower) Windows Version : https://download.docker.com/win/stable/DockerToolbox.exe
Docker for Mac : https://download.docker.com/mac/stable/Docker.dmg
Docker for Linux : Might well be included in your distro repositories
