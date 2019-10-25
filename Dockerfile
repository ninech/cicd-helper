FROM mikefarah/yq:latest AS yq
FROM google/cloud-sdk:latest

COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN apt-get update && apt-get install -y \
  openssh-client \
  git \
  bash \
  jq \
  && rm -rf /var/lib/apt/lists/*

COPY scripts/* /usr/local/bin
RUN chmod +x -R /usr/local/bin
