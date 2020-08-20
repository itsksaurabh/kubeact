FROM ubuntu:latest


# get all dependencies
RUN  apt-get update \
     && apt-get install -y acl curl libicu-dev \
     && apt-get -y install --reinstall systemd

WORKDIR /kubeact
RUN pwd
COPY scripts/setup.sh scripts/entrypoint.sh ./
RUN pwd && ls
RUN ./setup.sh

# Download the latest runner package
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.263.0/actions-runner-linux-x64-2.263.0.tar.gz
RUN ls && pwd
RUN tar -xzf actions-runner*.tar.gz && rm -f actions-runner*.tar.gz

ENV GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN GITHUB_USERNAME=$GITHUB_USERNAME GITHUB_REPO_NAME=$GITHUB_REPO_NAME
ENTRYPOINT ["su", "kubeactuser",  "./entrypoint.sh"]
