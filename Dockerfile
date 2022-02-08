FROM mikefarah/yq:3.1.1 AS yq
FROM google/cloud-sdk:latest

ARG ARGOCD_VERSION=v2.2.5
ARG KUSTOMIZE_VERSION=v3.5.4

COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN apt-get update && apt-get install -y \
  openssh-client \
  git \
  bash \
  jq \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L --output /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64

RUN curl -L --output ./kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
    tar -xvzf ./kustomize.tar.gz && \
    mv ./kustomize /usr/bin/ && \
    rm kustomize.tar.gz

COPY scripts/* /usr/local/bin
RUN chmod +x -R /usr/local/bin
