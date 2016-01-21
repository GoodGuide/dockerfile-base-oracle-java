FROM frolvlad/alpine-glibc:3.2

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=66 \
    JAVA_BUILD=17 \
    JAVA_DOWNLOAD_SHA256SUM=7e95ad5fa1c75bc65d54aaac9e9986063d0a442f39a53f77909b044cef63dc0a \

    JAVA_HOME=/usr/lib/jvm/default-jvm
ENV PATH=${PATH}:${JAVA_HOME}/bin

RUN set -x \
 && apk add --update wget ca-certificates \
 && cd /tmp \

# about nsswitch.conf - see https://registry.hub.docker.com/u/frolvlad/alpine-oraclejdk8/dockerfile/
 && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \

 && wget -nv --header "Cookie: oraclelicense=accept-securebackup-cookie;" -O jdk.tgz \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
 && sha256sum "jdk.tgz" | grep -q "${JAVA_DOWNLOAD_SHA256SUM}" \
 && tar -xzf "jdk.tgz" \

 && mkdir -p $(dirname "${JAVA_HOME}") \
 && mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
 && ln -s "java-${JAVA_VERSION}-oracle" $JAVA_HOME \
 && ln -s $JAVA_HOME/bin/java /usr/bin/java \
 && ln -s $JAVA_HOME/bin/javac /usr/bin/javac \

 && rm -rf $JAVA_HOME/*src.zip \
           $JAVA_HOME/lib/missioncontrol \
           $JAVA_HOME/lib/visualvm \
           $JAVA_HOME/lib/*javafx* \
           $JAVA_HOME/jre/lib/plugin.jar \
           $JAVA_HOME/jre/lib/ext/jfxrt.jar \
           $JAVA_HOME/jre/bin/javaws \
           $JAVA_HOME/jre/lib/javaws.jar \
           $JAVA_HOME/jre/lib/desktop \
           $JAVA_HOME/jre/plugin \
           $JAVA_HOME/jre/lib/deploy* \
           $JAVA_HOME/jre/lib/*javafx* \
           $JAVA_HOME/jre/lib/*jfx* \
           $JAVA_HOME/jre/lib/amd64/libdecora_sse.so \
           $JAVA_HOME/jre/lib/amd64/libprism_*.so \
           $JAVA_HOME/jre/lib/amd64/libfxplugins.so \
           $JAVA_HOME/jre/lib/amd64/libglass.so \
           $JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so \
           $JAVA_HOME/jre/lib/amd64/libjavafx*.so \
           $JAVA_HOME/jre/lib/amd64/libjfx*.so \
           $JAVA_HOME/jre/bin/jjs \
           $JAVA_HOME/jre/bin/keytool \
           $JAVA_HOME/jre/bin/orbd \
           $JAVA_HOME/jre/bin/pack200 \
           $JAVA_HOME/jre/bin/policytool \
           $JAVA_HOME/jre/bin/rmid \
           $JAVA_HOME/jre/bin/rmiregistry \
           $JAVA_HOME/jre/bin/servertool \
           $JAVA_HOME/jre/bin/tnameserv \
           $JAVA_HOME/jre/bin/unpack200 \
           $JAVA_HOME/jre/lib/ext/nashorn.jar \
           $JAVA_HOME/jre/lib/jfr.jar \
           $JAVA_HOME/jre/lib/jfr \
           $JAVA_HOME/jre/lib/oblique-fonts \
 && apk del wget ca-certificates \
 && rm /tmp/* /var/cache/apk/*

# Regenerate the JVM's shared class-data archive
RUN java -Xshare:dump
