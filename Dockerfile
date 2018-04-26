# oracle-java base on alpine
# Version: 0.0.1

FROM alpine:3.7

# Maintainers
MAINTAINER Carit Zhu "carit.zhu@witium.com"

# Environment parameters
ENV JAVA_VERSION=8 \
    JAVA_UPDATE=151 \
    JAVA_BUILD=12 \
    JAVA_PACKAGE=jre \
    JAVA_PATH=/usr/java \
    GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc \
    GLIBC_VERSION=2.27-r0 \
    LANG=en_US.UTF8

RUN apk add --no-cache --update-cache curl ca-certificates bash
RUN curl -Lo /etc/apk/keys/sgerrand.rsa.pub "https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub"
COPY glibc/glibc-${GLIBC_VERSION}.apk /tmp/glibc-${GLIBC_VERSION}.apk
RUN apk add /tmp/glibc-${GLIBC_VERSION}.apk
RUN rm -rf /tmp/* /var/cache/apk/*

# Add jre package
ADD ${JAVA_PACKAGE}/${JAVA_PACKAGE}-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz ${JAVA_PATH}/

# COPY profile /etc/profile

ENV JAVA_HOME=${JAVA_PATH}/${JAVA_PACKAGE}1.${JAVA_VERSION}.0_${JAVA_UPDATE}
ENV PATH=${PATH}:${JAVA_HOME}/bin

# Ports
