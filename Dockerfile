FROM mikefarah/yq:latest AS yq
FROM google/cloud-sdk:latest

COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN apt-get update && apt-get install -y \
  openssh-client \
  git \
  && rm -rf /var/lib/apt/lists/*
