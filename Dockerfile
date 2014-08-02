FROM goodguide/base

RUN aptitude install -y python-software-properties software-properties-common

RUN add-apt-repository -y ppa:webupd8team/java \
 && aptitude update \
 && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && apt-get install -y 'oracle-java7-installer=7u65+7u60arm-0~webupd8~2'

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
