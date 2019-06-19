FROM ubuntu:bionic-20180526@sha256:c8c275751219dadad8fa56b3ac41ca6cb22219ff117ca98fe82b42f24e1ba64e
USER root

# Install Haskell Stack and its dependencies
RUN apt-get update && apt-get install -yq --no-install-recommends --no-upgrade \
        ca-certificates \
        curl \
        g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase

WORKDIR /opt

# curl -sSL https://get.haskellstack.org/ | sh
RUN curl -sSL --output stack-2.1.1-linux-x86_64.tar.gz https://github.com/commercialhaskell/stack/releases/download/v2.1.1/stack-2.1.1-linux-x86_64.tar.gz
RUN tar zxf stack-2.1.1-linux-x86_64.tar.gz
RUN ln -s /opt/stack-2.1.1-linux-x86_64/stack /usr/bin/stack
RUN stack --version

WORKDIR /
RUN useradd --create-home stackuser

USER stackuser
WORKDIR /home/stackuser
RUN echo 'resolver: lts-13.25\npackages: []' > stack.yaml
RUN TAR_OPTIONS='--verbose --verbose --verbose' XZ_OPT='--verbose --verbose' stack setup --verbose --color always
