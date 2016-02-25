FROM garethjevans/jenkinsslave:v1.1.2

ENV MAVEN_VERSION 3.2.2
ENV MAVEN_HOME /opt/maven

RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

RUN mkdir -p /usr/share/sbt/0.13.9 && \
    curl -fL https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.9/sbt-launch.jar -o /usr/share/sbt/0.13.9/sbt-launch.jar


RUN chown jenkins:jenkins -R /home/jenkins

USER jenkins
WORKDIR /home/jenkins
