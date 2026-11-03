# syntax=docker/dockerfile:1
FROM debian:trixie-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        bash-completion \
        bind9-dnsutils \
        ca-certificates \
        curl \
        default-mysql-client \
        dhcpdump \
        git \
        iputils-ping \
        jq \
        mtr \
        nano \
        netcat-traditional \
        nmap \
        nnn \
        postgresql-client \
        python3-pip \
        openssh-client \
        openssl \
        redis-tools \
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

ARG WK_VERSION="4.9.5"
# werkzeugkasten reads WK_<TOOL>_TAG to pin a tool's version
ARG WK_KUBECTL_TAG="v1.37.2"
ARG WK_KUSTOMIZE_TAG="kustomize/v5.8.3"
ARG WK_HELM_TAG="v4.3.1"
ARG WK_FD_TAG="v10.5.0"
ARG WK_RIPGREP_TAG="15.2.0"
ARG WK_MICRO_TAG="v2.0.15"
ARG WK_YQ_TAG="v4.54.1"
ARG WK_CURLIE_TAG="v1.8.2"
ARG WK_KAF_TAG="v0.2.14"

# werkzeugkasten release assets use x86_64 instead of amd64.
# The optional github_token secret avoids GitHub API rate limits.
RUN --mount=type=secret,id=github_token,env=GITHUB_TOKEN WK_ARCH="$(echo "${TARGETARCH}" | sed s/amd64/x86_64/)" \
    && WK_BIN="werkzeugkasten_${WK_VERSION}_linux_${WK_ARCH}" \
    && curl -fsSLo "/tmp/${WK_BIN}" "https://github.com/Allaman/werkzeugkasten/releases/download/${WK_VERSION}/${WK_BIN}" \
    && curl -fsSL "https://github.com/Allaman/werkzeugkasten/releases/download/${WK_VERSION}/werkzeugkasten_${WK_VERSION}_checksums.txt" \
    | grep " ${WK_BIN}$" | sed "s|  |  /tmp/|" | sha256sum -c - \
    && install -m 755 "/tmp/${WK_BIN}" /usr/local/bin/werkzeugkasten \
    && werkzeugkasten -dir /usr/local/bin \
        -tool kubectl -tool kustomize -tool helm -tool fd -tool ripgrep -tool micro -tool yq -tool curlie -tool kaf \
    && rm -rf /tmp/* /root/.cache/werkzeugkasten

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
