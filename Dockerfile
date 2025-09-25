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
    # Python
    python3 python3-pip python3-venv python3-dev \
    # Misc
    patchelf \
    # Networking tools
    net-tools iproute2 iputils-ping dnsutils \
    && rm -rf /var/lib/apt/lists/*


# ============================================================
# Workspace setup
# ============================================================
WORKDIR /root/workspace

# ============================================================
# Python dependencies
# ============================================================
# Install any shared requirements (from unitree_g1_vibes)
RUN pip3 install --upgrade pip
COPY test_scripts/unitree_g1_vibes/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt || true

# ============================================================
# Default shell
# ============================================================
CMD ["/bin/bash"]
