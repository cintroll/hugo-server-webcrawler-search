FROM quay.io/fedora/fedora as base

ARG _VERSION=8.11.2
ARG _GID=1000
ARG _UID=1000
ARG _USERNAME=solr
ARG _GROUPNAME=solr

USER root

RUN yum update -y
RUN yum install java-11-openjdk lsof -y

RUN groupadd -g ${_GID} ${_GROUPNAME}
RUN useradd -u ${_UID} ${_USERNAME} -g ${_GID}

RUN mkdir /opt/solr
RUN curl https://dlcdn.apache.org/lucene/solr/${_VERSION}/solr-${_VERSION}.tgz -o /tmp/solr.tgz
RUN tar -C /opt/solr --strip-components=1 -xzf /tmp/solr.tgz && rm /tmp/solr.tgz


RUN mkdir -p /opt/solr/server/solr/configsets/nutch/
RUN cp -r /opt/solr/server/solr/configsets/_default/* /opt/solr/server/solr/configsets/nutch/
COPY src/ /opt/solr/
RUN chown -R ${_USERNAME}:${_GROUPNAME} /opt/solr
RUN chmod -R +x /opt/solr/bin/*
RUN chmod +x /opt/solr/entrypoint.sh

FROM base

ARG _USERNAME=solr

ENV JAVA_HOME=/usr/lib/jvm/jre-11

USER $_USERNAME
VOLUME [ "/opt/solr/crawl" ]
EXPOSE 8983
WORKDIR /opt/solr
ENTRYPOINT [ "sh", "/opt/solr/entrypoint.sh" ]
