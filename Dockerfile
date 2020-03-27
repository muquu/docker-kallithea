FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV LANG=en_US.UTF-8
ENV KALLITHEA_VERSION 0.5.2

#RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y tzdata locales \
  && echo "${TZ}" > /etc/timezone \
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && locale-gen en_US.UTF-8 ja_JP.UTF-8 \
  && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y curl build-essential git python-pip python-virtualenv libffi-dev python-dev \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y nodejs \
  && npm install npm@latest -g \
  && pip install kallithea==${KALLITHEA_VERSION}

RUN kallithea-cli front-end-build

RUN rm -rf /var/lib/apt/lists/*
EXPOSE 5000
CMD ["gearbox", "serve", "-c", "/srv/kallithea/my.ini"]
