ARG BASE_CONTAINER=jupyter/base-notebook
FROM $BASE_CONTAINER
#FROM ubuntu:bionic-20180526@sha256:c8c275751219dadad8fa56b3ac41ca6cb22219ff117ca98fe82b42f24e1ba64e
USER root

# Install Haskell Stack and its dependencies
RUN apt-get update && apt-get install -yq --no-install-recommends \
# for stack installation
        curl \
        && \
    curl -sSL https://get.haskellstack.org/ | sh

# Switch back to jovyan user
USER $NB_UID

WORKDIR /home/jovyan

RUN \
    echo 'resolver: lts-13.25\npackages: []' > stack.yaml && \
#    TAR_OPTIONS='--verbose --verbose --verbose --ignore-command-error --ignore-failed-read' XZ_OPT='--verbose --verbose' stack setup --verbose
    TAR_OPTIONS='--verbose --verbose --verbose' XZ_OPT='--verbose --verbose' stack setup --verbose
