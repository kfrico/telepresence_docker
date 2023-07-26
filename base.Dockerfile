FROM google/cloud-sdk:latest

RUN apt-get update && apt-get install vim wget iptables sudo bash-completion -y

#telepresence
RUN curl -sO https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh && \
    env os=ubuntu dist=xenial bash script.deb.sh && \
    apt install --no-install-recommends telepresence=0.109 -y && \
    rm script.deb.sh


