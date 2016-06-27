FROM garethjevans/jenkinsslave:v1.1.3

ENV MAVEN_VERSION 3.2.2
ENV MAVEN_HOME /opt/maven
ENV SBT_VERSION 0.13.9
ENV GRADLE_VERSION 2.11

RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} ${MAVEN_HOME} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

RUN mkdir -p /usr/share/sbt/${SBT_VERSION} && \
    curl -fL https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/${SBT_VERSION}/sbt-launch.jar -o /usr/share/sbt/${SBT_VERSION}/sbt-launch.jar

RUN mkdir -p /usr/share/gradle/ && \
    curl -fL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -o /usr/share/gradle/gradle-${GRADLE_VERSION}-all.zip && \
    unzip /usr/share/gradle/gradle-${GRADLE_VERSION}-all.zip -d /usr/share/gradle/ && \
    rm /usr/share/gradle/gradle-${GRADLE_VERSION}-all.zip && \
    ln -s /usr/share/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin

RUN chown jenkins:jenkins -R /home/jenkins

USER jenkins
WORKDIR /home/jenkins
