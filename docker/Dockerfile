ARG tag=20.04
FROM ubuntu:${tag}

# Author
MAINTAINER vixadd

# extra metadata
LABEL version="0.0.0"
LABEL description="Shortsite website for personal use."
LABEL project="SHORTSITE"

USER root

# Custom Build Arguments
ARG UID=1001
ARG GID=1001
ARG NODE_VER=16.14.1

ARG VERSION=0.0.0
ARG USERNAME=ubuntu

RUN apt -y update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt install -y python3-pip vim emacs sudo

RUN groupadd -r -g $GID vixadd && \
    useradd -m -r -u $UID -g $GID vixadd && \
    echo "vixadd ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vixadd && \
    usermod -a -G sudo vixadd && \
    echo 'vixadd:password' | chpasswd

RUN apt-get update -y && apt-get install -y build-essential

RUN mkdir /opt/shortsite && chown vixadd:vixadd -R /opt/
RUN pip install --upgrade pip

ARG GPU=True

# install basic apps, one per line for better caching
RUN apt-get install -qy git
RUN apt-get install -qy locales
RUN apt-get install -qy nano
RUN apt-get install -qy tmux
RUN apt-get install -qy wget
RUN pip install --upgrade pip

RUN mkdir -p /opt/shortsite
RUN chown vixadd:vixadd -R /opt/shortsite/

USER vixadd

WORKDIR /opt/shortsite

ENV NODE_VERSION=${NODE_VER}
RUN sudo -E apt-get install -y curl wget python3 python3-pip python3-pystache python3-yaml
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/home/vixadd/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/home/vixadd/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Conduct NPM Installation
ADD package.json /opt/shortsite/
RUN npm install -g npm@latest
RUN npm install

RUN echo "export PATH=/home/ubuntu/.local/bin:$PATH" >> ~/.bashrc
RUN echo "export PATH=/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}" >> ~/.bashrc
