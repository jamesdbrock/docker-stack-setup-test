ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

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
    echo 'resolver: lts-13.25' > stack.yaml && \
    TAR_OPTIONS='--verbose --verbose --verbose --ignore-command-error --ignore-failed-read' XZ_OPT='--verbose --verbose' stack setup --verbose
