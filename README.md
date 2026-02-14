# 🛠 Android-CI-CD-Builder

This repository contains a Docker configuration designed to automate the build (CI) and delivery (CD) processes for Android applications. It provides a complete environment, from the SDK to a pre-configured emulator.

Official Website: [udfsoft.com](https://udfsoft.com/)

---

## ✨ Key Features
  * **Multi-JDK Support**: Pre-installed OpenJDK 8 and OpenJDK 17 to support both legacy and modern Gradle versions.
  * **Ready-to-use SDK**: Automated installation of Android SDK, Build Tools, and Platform Tools via build arguments.
  * **Built-in Emulator**: Pre-configured Nexus 5 (API 29) system image for running instrumentation tests.
  * **CI/CD Ready**: Includes a GitHub Action to automatically build and push the image to Docker Hub.


## 🏗 Image Composition

| Component             | Version / Description              |  
|-----------------------|------------------------------------|
| Base OS               | Ubuntu Latest                      |
| Java Versions         | 8 & 17 (17 set as default)         |
| Android AVD           | mynexus (Google APIs, x86, API 29) |
| Included Tools        | adb, fastboot, curl, wget, unzip   |
 
 ---

## 🚀 Quick Start

Pull from Docker Hub
You can quickly pull the latest ready-to-use image:

```Bash
docker pull javavirys/android:36
```

👉 Docker Hub Repository: [javavirys/android](https://hub.docker.com/r/javavirys/android)

**Local Build**
To build the image manually with your specific parameters, use the _--build-arg _ flag:
```Bash
docker build \
  --build-arg android_compile_sdk=33 \
  --build-arg android_build_tools=30.0.3 \
  --build-arg android_sdk_tools=4333796 \
  -t your-username/android:33 .
```
## CI/CD Integration

To enable automatic image deployment on every push, configure the following Secrets in your GitHub repository settings:
  * DOCKER_USERNAME — Your Docker Hub username.
  * DOCKER_PASSWORD — Your Docker Hub Access Token (recommended) or password.

---

## ⚙️ GitHub Action Workflow
The automation process is defined in ```.github/workflows/main.yml```:
  1. Checkout: Clones the repository code.
  2. Publish: Builds the Docker image by passing SDK versions as buildargs and pushes the result to the Registry.

---

## 💡 Optimization Tips (Pro-tips)
[!IMPORTANT]**The PATH Issue**: In your current Dockerfile, the RUN export PATH=... command only applies within that specific layer. To ensure adb and emulator are accessible in any container instance, use the ENV instruction instead.
**Recommended fix for your Dockerfile:** 
```Dockerfile
ENV PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/tools/bin:$ANDROID_SDK/platform-tools:$PATH
```

---

## 📄 License
This project is licensed under the MIT License.
