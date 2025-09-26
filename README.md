# 🚀 G1 Testing Environment

This repository provides a **Docker-based development environment** for the Unitree G1 robot and its supporting sensors (Livox LiDAR, Intel RealSense).  

It ensures a consistent Ubuntu 22.04 setup, avoiding compatibility issues with other host systems.  
The container comes with preinstalled developer tools, Python, OpenCV, and USB/network access for hardware testing.  

---

## 🔧 Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed  
- [Docker Compose](https://docs.docker.com/compose/install/) installed  
- Host system tested on **Ubuntu 24.04**  
- Optional: enable X11 GUI forwarding for visualization tools  

---

## 🐳 Build the Docker Image
From the project root:
```bash
sudo docker-compose up --build -d
```
this builds the image defined in the `Dockerfile` (Ubuntu 22.04 + required dependencies)

start the container:
```bash
sudo docker-compose up -d
```
attach to it:
```bash
sudo docker exec -it g1_dev_env /bin/bash
```

from the docker-compose.yml, this container will have access to USB and networking devices necessary for control

when finished, clean up:
```bash
sudo docker-compose down
```

