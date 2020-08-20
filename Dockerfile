FROM ubuntu:latest


# get all dependencies
RUN  apt-get update \
     && apt-get install -y acl curl libicu-dev \
     && apt-get -y install --reinstall systemd

RUN useradd -ms /bin/bash kubeactuser
WORKDIR /home/kubeactuser/kubeact
RUN chown -R kubeactuser:kubeactuser /home/kubeactuser/kubeact/
USER kubeactuser
COPY scripts/setup.sh scripts/entrypoint.sh ./
#RUN ./setup.sh

# Download the latest runner package
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.263.0/actions-runner-linux-x64-2.263.0.tar.gz 
RUN tar -xzf actions-runner*.tar.gz && rm -f actions-runner*.tar.gz
#ENV RUNNER_ALLOW_RUNASROOT true
ENV GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN GITHUB_USERNAME=$GITHUB_USERNAME GITHUB_REPO_NAME=$GITHUB_REPO_NAME
ENTRYPOINT ["./entrypoint.sh"]
