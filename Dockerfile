FROM garethjevans/jenkinsslave:latest

# Install JDK 7
ENV JAVA_VERSION 1.7.0_72
ENV FILENAME jdk-7u72-linux-x64.tar.gz
ENV DOWNLOADLINK http://download.oracle.com/otn-pub/java/jdk/7u72-b14/${FILENAME}
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/${FILENAME} ${DOWNLOADLINK} && \
    tar -zxf /tmp/${FILENAME} -C /opt/ && \
    update-alternatives --install /usr/bin/java java /opt/jdk${JAVA_VERSION}/bin/java 2 && update-alternatives --install /usr/bin/javac javac /opt/jdk${JAVA_VERSION}/bin/javac 2

# Install JDK 8 (latest edition)
RUN apt-get update
RUN apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install -y openjdk-8-jdk

ENV MAVEN_VERSION 3.2.2
ENV MAVEN_HOME /opt/maven

RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

RUN java -version 
