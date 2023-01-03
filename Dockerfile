ARG baseImage=openjdk:11

FROM ${baseImage}

ARG androidSdkBuildToolsVersion=33.0.1
ARG androidSdkDir=/opt/android
ARG androidSdkPlatformVersion=30
ARG androidSdkToolsVersion=9123335
ARG flutterSdkDir=/opt/flutter
ARG flutterSdkVersion=3.3.10

ARG workingDir=/workspace

ENV ANDROID_HOME=${androidSdkDir}
ENV FLUTTER_SDK_HOME=${flutterSdkDir}

# Download and install android SDK
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${androidSdkToolsVersion}_latest.zip -O android-sdk.zip
RUN unzip -qq -o android-sdk.zip -d temp && rm -f android-sdk.zip
RUN mkdir -p ${androidSdkDir}/cmdline-tools && mv temp/cmdline-tools ${androidSdkDir}/cmdline-tools/latest && rm -rf temp

# Put android SDK in path
ENV PATH="${androidSdkDir}/cmdline-tools/latest/bin:$PATH"
ENV PATH="${androidSdkDir}/cmdline-tools/tools/bin:$PATH"
ENV PATH="${androidSdkDir}/platform-tools/bin:$PATH"
ENV PATH="${androidSdkDir}/tools/bin:$PATH"

# Install required tools
RUN yes | sdkmanager "build-tools;${androidSdkBuildToolsVersion}"
RUN yes | sdkmanager "extras;android;m2repository"
RUN yes | sdkmanager "extras;google;m2repository"
RUN yes | sdkmanager "extras;google;instantapps"
RUN yes | sdkmanager "platform-tools"
RUN yes | sdkmanager "platforms;android-${androidSdkPlatformVersion}"
RUN yes | sdkmanager --licenses

# Download and install flutter SDK
RUN git clone https://github.com/flutter/flutter ${flutterSdkDir}
RUN cd ${flutterSdkDir} && git checkout ${flutterSdkVersion}

# Put flutter SDK in path
ENV PATH="${flutterSdkDir}/bin:$PATH"

# Run flutter doctor
RUN flutter doctor --android-licenses

# Cache common deps
RUN flutter precache

# Set up workspace
RUN mkdir -p ${workingDir}
WORKDIR ${workingDir}