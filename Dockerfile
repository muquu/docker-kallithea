FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV LANG=en_US.UTF-8
ENV KALLITHEA_VERSION 0.6.1

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y tzdata locales \
  && echo "${TZ}" > /etc/timezone \
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && locale-gen en_US.UTF-8 ja_JP.UTF-8 \
  && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y curl build-essential git libffi-dev python3-dev python3-pip nginx nginx-common nginx-full\
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y nodejs \
  && npm install npm@latest -g \
  && pip3 install kallithea==${KALLITHEA_VERSION}

RUN kallithea-cli front-end-build

COPY ./start.sh /
RUN  chmod a+x /start.sh
COPY ./nginx/kallithea /etc/nginx/sites-available/kallithea
RUN unlink /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/kallithea /etc/nginx/sites-enabled/
COPY ./nginx/proxy.conf /etc/nginx/proxy.conf
RUN rm -rf /var/lib/apt/lists/*
EXPOSE 80
#CMD ["gearbox", "serve", "-c", "/srv/kallithea/my.ini"]
CMD ["/start.sh"]