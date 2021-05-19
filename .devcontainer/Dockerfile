# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.159.0/containers/rust/.devcontainer/base.Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/rust:0-1

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql

USER vscode
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN bash -c 'source $HOME/.nvm/nvm.sh   && \
    nvm install node'
RUN cargo install sqlx-cli --no-default-features --features postgres

USER root
