FROM quay.io/goodguide/base:ubuntu-15.10-0

ENV JAVA_VERSION=8

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" >> /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" >> /etc/apt/sources.list.d/webupd8team-java.list \

 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
 && apt-get update \
 && echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && apt-get install \
      oracle-java${JAVA_VERSION}-installer \
      oracle-java${JAVA_VERSION}-set-default \
      ant

# Set JDK default env vars in /etc/environment
RUN bash -c 'source /etc/profile.d/jdk.sh && env' | grep -E '(PATH|(JAVA|DERBY)_HOME|J2.+?)=' | sort | tee -a /etc/environment

# Install Maven
ARG MAVEN_VERSION=3.3.9
RUN set -x \
 && cd /tmp \
 && curl -fsSL -o maven.tgz "http://apache.cs.utah.edu/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
 && curl -fsSL -o maven.sha1 "https://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz.sha1" \
 && shasum -a1 maven.tgz | grep -q "$(<maven.sha1)" \
 && mkdir -p /opt/maven \
 && tar -xvz --strip-components=1 -C /opt/maven -f maven.tgz \
 && rm maven.tgz maven.sha1

ENV PATH /opt/maven/bin:$PATH
