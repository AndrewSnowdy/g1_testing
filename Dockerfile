# ============================================================
# Base image: Ubuntu 22.04 (LTS, stable for robotics SDKs)
# ============================================================
FROM ubuntu:22.04

# Avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# ============================================================
# System dependencies
# ============================================================
RUN apt-get update && apt-get install -y \
    # Build tools
    build-essential cmake git wget curl pkg-config \
    # USB / hardware support
    libusb-1.0-0-dev \
    # Graphics & GUI
    libgl1-mesa-glx libglfw3-dev libgtk-3-dev \
    # SSL + networking
    libssl-dev \
    # OpenCV
    libopencv-dev \
    # Unitree SDK2 dependency
    libeigen3-dev \
    # Python
    python3 python3-pip python3-venv python3-dev \
    # Misc
    patchelf \
    # Networking tools
    net-tools iproute2 iputils-ping dnsutils \
    && rm -rf /var/lib/apt/lists/*


# ------------------------
# Install CycloneDDS system-wide
# ------------------------
WORKDIR /opt
RUN git clone https://github.com/eclipse-cyclonedds/cyclonedds -b releases/0.10.x && \
    cd cyclonedds && \
    mkdir build install && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/opt/cyclonedds/install && \
    cmake --build . --target install && \
    rm -rf /opt/cyclonedds/build

# Environment variables so Unitree SDKs find CycloneDDS
ENV CYCLONEDDS_HOME=/opt/cyclonedds/install
ENV CMAKE_PREFIX_PATH=/opt/cyclonedds/install
# Ensure the dynamic linker can find CycloneDDS libs
ENV LD_LIBRARY_PATH=/opt/cyclonedds/install/lib:$LD_LIBRARY_PATH

# ============================================================
# Workspace setup
# ============================================================
WORKDIR /root/workspace


# ============================================================
# Default shell
# ============================================================
CMD ["/bin/bash"]