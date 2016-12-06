FROM debian:testing
MAINTAINER Cheewai Lai <clai@csir.co.za>
ARG DEBIAN_FRONTEND=noninteractive
ARG GOSU_VERSION=1.10
#ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install curl python python-dev python-pip build-essential \
 && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
 && chmod +x /usr/local/bin/gosu \
 && pip install --upgrade pip \
 && pip install PyYAML \
 && pip install puka \
 && pip install gevent \
 && pip install gevent_inotifyx \
 && pip install rethinkdb \
 && pip install pyinotify \
 && pip install blinker raven --upgrade \
 && apt-get -y remove --purge python-dev build-essential \
 && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh \
 && chown root.root /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
