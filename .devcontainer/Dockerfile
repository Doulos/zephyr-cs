# Copyright (c) 2024 Doulos
# SPDX-License-Identifier: Apache-2.0

ARG ZEPHYR_SDK_VERSION=0.16.8
ARG ZEPHYR_SDK_INSTALL_DIR=/opt/toolchains/zephyr-sdk-${ZEPHYR_SDK_VERSION}
ARG ZEPHYR_SDK_TOOLCHAINS="-t arm-zephyr-eabi"
ARG BASE_IMAGE="ghcr.io/embeddedcontainers/zephyr:base-${ZEPHYR_SDK_VERSION}SDK"

FROM ${BASE_IMAGE}


#------------------------------------------------------
# Setup for tun/tap devices
#------------------------------------------------------
RUN \
  apt-get -y update \ 
  && apt-get -y install iproute2 \
  && apt-get clean \ 
  && rm -rf /var/libs/apt/lists/* \
  && mkdir -p /dev/net && mknod /dev/net/tun c 10 200


#------------------------------------------------------
# OS dependencies and packages
#------------------------------------------------------
RUN \
  apt-get -y update \
  && apt-get -y install --no-install-recommends \
  gcc-multilib \
  make \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


#------------------------------------------------------
# Zephyr SDKs
#------------------------------------------------------
ARG ZEPHYR_SDK_INSTALL_DIR
ARG ZEPHYR_SDK_TOOLCHAINS
RUN \
  apt-get -y update \
  && apt-get -y install --no-install-recommends \
  tree \
  xz-utils \
  wget \
  file \
  locales \
  && ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -c ${ZEPHYR_SDK_TOOLCHAINS} \
  && ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -h \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen \
  && apt-get remove -y --purge \
  wget \
  xz-utils \
  && apt-get clean 
