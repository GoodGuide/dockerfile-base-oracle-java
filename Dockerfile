FROM quay.io/goodguide/base:ubuntu-15.10-0

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=66

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" >> /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" >> /etc/apt/sources.list.d/webupd8team-java.list \

 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
 && apt-get update \
 && echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && apt-get install \
      "oracle-java${JAVA_VERSION}-installer=${JAVA_VERSION}u${JAVA_UPDATE}+*" \
      oracle-java${JAVA_VERSION}-set-default \
      ant \

# Set JDK default env vars in /etc/environment
 && bash -c 'source /etc/profile.d/jdk.sh && env' | grep -E '(PATH|(JAVA|DERBY)_HOME|J2.+?)=' | sort | tee -a /etc/environment
