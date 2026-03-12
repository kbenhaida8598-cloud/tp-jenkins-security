FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y wget unzip openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip -P /opt \
    && unzip /opt/sonar-scanner-cli-5.0.1.3006-linux.zip -d /opt \
    && mv /opt/sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner \
    && rm /opt/sonar-scanner-cli-5.0.1.3006-linux.zip

ENV PATH="/opt/sonar-scanner/bin:${PATH}"

USER jenkins
