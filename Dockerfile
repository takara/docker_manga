FROM debian:8.7

MAINTAINER takara

WORKDIR /root

RUN apt-get -y update
RUN apt-get install -y wget
COPY asset/sources.list /etc/apt/
RUN wget https://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg && \
    rm dotdeb.gpg

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install net-tools git make apache2 sqlite3
RUN apt-get -y install vim curl chkconfig gcc libpcre3-dev unzip locales
RUN apt-get -y install mysql-server php php-pear php-mysql php-curl php-mbstring php-zip php-gd php-sqlite3
ENV DEBIAN_FRONTEND dialog

# tty停止
COPY asset/ttystop /etc/init.d/
RUN chkconfig --add ttystop
RUN chkconfig ttystop on

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

COPY asset/000-default.conf /etc/apache2/sites-available/

COPY asset/.bash_profile /root/
COPY asset/apache2/php.ini /etc/php/7.0/apache2/
COPY asset/cli/php.ini /etc/php/7.0/cli/

EXPOSE 80

CMD ["/sbin/init", "3"]
