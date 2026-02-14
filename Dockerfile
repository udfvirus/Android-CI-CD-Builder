FROM ubuntu:latest

LABEL maintainer="javavirys@gmail.com"
USER root

ARG DEBIAN_FRONTEND=noninteractive

ARG android_compile_sdk
ARG android_build_tools
ARG android_sdk_tools

ENV ANDROID_HOME="/usr/local/android-sdk"
ENV ANDROID_SDK_ROOT="/usr/local/android-sdk"

ENV PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${PATH}"

# RUN apt-get update && apt-get install -y \
#     unzip \
#     curl \
#     wget \
#     software-properties-common \
#     libgl1-mesa-glx \
#     openjdk-17-jdk \
#     android-tools-adb \
#     android-tools-fastboot \
#     && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata \
    unzip \
    curl \
    wget \
    git \
    software-properties-common \
    libgl1-mesa-glx \
    openjdk-17-jdk \
    android-tools-adb \
    android-tools-fastboot \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "$ANDROID_HOME/cmdline-tools" .android \
    && curl -o sdk.zip "https://dl.google.com/android/repository/commandlinetools-linux-${android_sdk_tools}_latest.zip" \
    && unzip sdk.zip -d "$ANDROID_HOME/cmdline-tools" \
    && mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest" \
    && rm sdk.zip

RUN yes | sdkmanager --licenses

RUN sdkmanager "build-tools;${android_build_tools}" \
    "platforms;android-${android_compile_sdk}" \
    "platform-tools" "emulator" \
    "system-images;android-29;google_apis;x86"


RUN avdmanager create avd -n mynexus \
    -k "system-images;android-29;google_apis;x86" \
    --tag "google_apis" \
    --device "Nexus 5"

RUN apt-get update && apt-get install -y openjdk-8-jdk && rm -rf /var/lib/apt/lists/*
