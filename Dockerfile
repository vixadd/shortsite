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

RUN groupadd -r -g $GID ubuntu && \
    useradd -m -r -u $UID -g $GID ubuntu && \
    echo "%sudo ALL=(ALL) ALL" > /etc/sudoers && \
    usermod -a -G sudo ubuntu && \
    echo 'ubuntu:password' | chpasswd

RUN apt-get update -y && apt-get install -y build-essential

ENV NODE_VERSION=${NODE_VER}
RUN apt-get install -y curl wget python3 python3-pip python3-psycopg2 python3-pystache python3-yaml
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN mkdir /opt/checrs && chown ubuntu:ubuntu -R /opt/
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
RUN chown ubuntu:ubuntu -R /opt/shortsite/

USER ubuntu

WORKDIR /opt/shortsite

RUN echo "export PATH=/home/ubuntu/.local/bin:$PATH" >> ~/.bashrc
RUN echo "export PATH=/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}" >> ~/.bashrc


