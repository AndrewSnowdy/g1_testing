# Use the official Ubuntu 22.04 image as our base
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies needed for robotics, Python, and compilation
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libusb-1.0-0-dev \
    patchelf \
    python3 \
    python3-pip \
    libgl1-mesa-glx \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace directory inside the container
WORKDIR /root/workspace

# Set the default command to a bash shell
CMD ["/bin/bash"]
