ARG ARCH=
FROM ${ARCH}debian:stable-slim

RUN apt-get update \
&& apt-get install -y \
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
  nano \
  netcat \
  nmap \
  nnn \
  openssh-client \
  openssl \
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

ENV KUBE_VERSION="v1.20.0"
ENV KUSTOMIZE_VERSION="v4.4.0"
ENV YQ_VERSION="v4.16.2"
ENV HELM_VERSION="v3.1.0"

# Download tools that are not available as Debian package
RUN curl -sLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH} && \
    curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
    curl -sLo /tmp/kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${TARGETARCH}.tar.gz && \
    tar -xC /usr/local/bin/ -f /tmp/kustomize.tar.gz && \
    curl -sLo /tmp/helm-${HELM_VERSION}.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
    tar -xC /tmp -f /tmp/helm-${HELM_VERSION}.tar.gz linux-${TARGETARCH}/helm --strip-components=1 && \
    mv /tmp/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/*

ENTRYPOINT [ "/bin/bash" ]
