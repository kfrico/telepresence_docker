FROM google/cloud-sdk:latest

RUN apt-get update && apt-get install vim wget iptables sudo bash-completion -y

#gcp
ADD ./docker-entrypoint.sh /docker-entrypoint.sh

#k9s
RUN wget https://github.com/derailed/k9s/releases/download/0.9.3/k9s_0.9.3_Linux_arm64.tar.gz && \
    tar -C /tmp -xzf k9s_0.9.3_Linux_arm64.tar.gz && \
    rm k9s_0.9.3_Linux_arm64.tar.gz && \
    mv /tmp/k9s /usr/bin/k9s 

#golang
RUN wget https://dl.google.com/go/go1.20.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz && \
    rm go1.20.4.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/src/code" && chmod -R 777 "$GOPATH"

#telepresence
RUN curl -sO https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh && \
    env os=ubuntu dist=xenial bash script.deb.sh && \
    apt install --no-install-recommends telepresence=0.109 -y && \
    rm script.deb.sh

#kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

WORKDIR "$GOPATH/src/code"

ENV SCOUT_DISABLE=1

ENTRYPOINT ["/docker-entrypoint.sh"]
