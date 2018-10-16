FROM jenkins/jenkins:2.144

#It stores the uncompressed Jenkins war file in jenkins_home, which means we’d preserve this data between Jenkins runs. This is not ideal as we don’t need to save this data and it could cause confusion when moving between Jenkins versions
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

USER root

RUN apt-get update
RUN apt-get -y install apt-transport-https

RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" >> /etc/apt/sources.list.d/docker.list

RUN echo "13.32.28.246 download.docker.com" >> /etc/hosts


RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins


RUN apt-get update

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey

RUN apt-get update
RUN apt-get -y install docker-ce

USER jenkins
