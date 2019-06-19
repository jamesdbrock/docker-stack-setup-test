FROM ubuntu:bionic-20180526@sha256:c8c275751219dadad8fa56b3ac41ca6cb22219ff117ca98fe82b42f24e1ba64e
USER root

# Install Haskell Stack and its dependencies
RUN apt-get update && apt-get install -yq --no-install-recommends \
        ca-certificates \
        curl \
        && \
    curl -sSL https://get.haskellstack.org/ | sh

RUN useradd --create-home stackuser

USER stackuser
WORKDIR /home/stackuser

RUN echo 'resolver: lts-13.25\npackages: []' > stack.yaml && \
    TAR_OPTIONS='--verbose --verbose --verbose' XZ_OPT='--verbose --verbose' stack setup --verbose --color always
