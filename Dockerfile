ARG ARCH=
FROM ${ARCH}debian:bookworm-slim

RUN apt-get update \
&& apt-get install --no-install-recommends -y \
  azure-cli \
  awscli \
  bash-completion \
  curl \
  default-mysql-client \
  dhcpdump \
  dnsutils \
  fd-find \
  git \
  httpie \
  iputils-ping \
  jq \
  kafkacat \
  micro \
  mtr \
  nano \
  netcat-traditional \
  nmap \
  nnn \
  postgresql-client-15 \
  python3-pip \
  openssh-client \
  openssl \
  redis-tools \
  ripgrep \
  s4cmd \
  tar \
  tcpdump \
  telnet \
  traceroute \
  unzip \
  vim \
  wget \
  zip \
&& rm -rf /var/lib/apt/lists/*

ARG TARGETOS
ARG TARGETARCH

ENV KUBE_VERSION="v1.26.0"
ENV KUSTOMIZE_VERSION="v5.3.0"
ENV YQ_VERSION="v4.41.1"
ENV HELM_VERSION="v3.12.3"
ENV PATH=$PATH:/usr/local/go/bin

# Download tools that are not available as Debian package
RUN curl -sLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH} && \
    curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
    curl -sLo /tmp/kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${TARGETARCH}.tar.gz && \
    tar -xC /usr/local/bin/ -f /tmp/kustomize.tar.gz && \
    curl -sLo /tmp/helm-${HELM_VERSION}.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
    tar -xC /tmp -f /tmp/helm-${HELM_VERSION}.tar.gz linux-${TARGETARCH}/helm --strip-components=1 && \
    mv /tmp/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/*

RUN curl -sLo go.tar.gz https://go.dev/dl/go1.18.linux-${TARGETARCH}.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
