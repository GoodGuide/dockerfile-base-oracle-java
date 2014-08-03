FROM goodguide/base

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
 && aptitude update

RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && aptitude install --without-recommends --assume-yes  'oracle-java6-installer=6u45-0~webupd8~8' \
 && aptitude clean

ENV JAVA_HOME /usr/lib/jvm/java-6-oracle
