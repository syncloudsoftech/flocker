ARG baseImage=androidsdk/android-30

FROM ${baseImage}

ARG flutterSdkDir=/opt/flutter
ARG flutterSdkVersion=3.3.10

ARG workingDir=/workspace

ENV FLUTTER_SDK_HOME=$flutterSdkDir

# download and install flutter
RUN git clone https://github.com/flutter/flutter $FLUTTER_SDK_HOME
RUN cd $FLUTTER_SDK_HOME && git checkout ${flutterSdkVersion}

# Set flutter environment path
ENV PATH="$FLUTTER_SDK_HOME/bin:$PATH"

# Run flutter doctor
RUN flutter doctor --android-licenses

# Cache common deps
RUN flutter precache

# Set up workspace
RUN mkdir -p ${workingDir}
WORKDIR ${workingDir}
