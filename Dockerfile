FROM ubuntu:latest

# build args
ARG GITHUB_ACCESS_TOKEN
ARG GITHUB_USERNAME
ARG GITHUB_REPO_NAME

# get all dependencies
RUN  apt-get update && apt-get install -y acl \
     && apt-get install -y curl \
     && apt-get install -y libicu-dev \
     && apt-get -y install --reinstall systemd

WORKDIR /kubeact
COPY scripts/setup.sh scripts/config.sh ./
RUN chmod +x setup.sh
RUN ./setup.sh
ENTRYPOINT ["su", "kubeactuser", "./actions-runner/run.sh"]