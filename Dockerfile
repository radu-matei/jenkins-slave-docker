FROM jenkinsci/slave:alpine

USER root
RUN apk add --no-cache \
ca-certificates \
curl \
openssl

ENV DOCKER_BUCKET download.docker.com
ENV DOCKER_VERSION 17.06.0-ce
ENV DOCKER_SHA256 e582486c9db0f4229deba9f8517145f8af6c5fae7a1243e6b07876bd3e706620

RUN set -x \
&& curl -fsSL "https://${DOCKER_BUCKET}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
&& tar -xzvf docker.tgz \
&& mv docker/* /usr/local/bin/ \
&& rmdir docker \
&& rm docker.tgz \
&& docker -v

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

COPY docker-entrypoint.sh /usr/local/bin/

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/jenkins-slave

ENTRYPOINT docker-entrypoint.sh; jenkins-slave

