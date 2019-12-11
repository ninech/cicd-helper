FROM mikefarah/yq:latest AS yq
FROM google/cloud-sdk:latest

ARG ARGOCD_VERSION=v1.2.5

COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN apt-get update && apt-get install -y \
  openssh-client \
  git \
  bash \
  jq \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L --output /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64

COPY scripts/* /usr/local/bin
RUN chmod +x -R /usr/local/bin
