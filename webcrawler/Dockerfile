FROM quay.io/fedora/fedora as base

ARG _VERSION=1.19
ARG _GID=1000
ARG _UID=1000
ARG _USERNAME=nutch
ARG _GROUPNAME=nutch

USER root

RUN yum update -y
RUN yum install java-11-openjdk -y

RUN groupadd -g ${_GID} ${_GROUPNAME}
RUN useradd -u ${_UID} ${_USERNAME} -g ${_GID}

RUN mkdir /opt/nutch
RUN curl https://dlcdn.apache.org/nutch/${_VERSION}/apache-nutch-${_VERSION}-bin.tar.gz -o /tmp/apache-nutch.tar.gz
RUN tar -C /opt/nutch --strip-components=1 -xzf /tmp/apache-nutch.tar.gz && rm /tmp/apache-nutch.tar.gz


COPY src/ /opt/nutch/
RUN mkdir /opt/nutch/crawl
RUN chown -R ${_USERNAME}:${_GROUPNAME} /opt/nutch
RUN chmod -R +x /opt/nutch/bin/*
RUN chmod +x /opt/nutch/entrypoint.sh

FROM base

ARG _USERNAME=nutch

ENV JAVA_HOME=/usr/lib/jvm/jre-11

USER $_USERNAME
VOLUME [ "/opt/nutch/crawl" ]
WORKDIR /opt/nutch
ENTRYPOINT [ "sh", "/opt/nutch/entrypoint.sh" ]
