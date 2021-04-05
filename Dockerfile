FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

LABEL \
  maintainer="TKVictor-Hang@outlook.fr"

ENV \
  DISPLAY=:1 \
  XDG_RUNTIME_DIR=/mgba \
  HOME=/config

RUN \
  apt update && apt upgrade -y && \
  apt install -y dpkg && \
  echo "Install required tools" && \
  apt install -y p7zip wget curl && \
  echo "Install vnc, novnc, websockify to move the gui accessible with the browser" && \
  apt install -y  novnc websockify xvfb x11vnc fluxbox

RUN \
  echo "Download latest mGBA from github repo"
ADD https://api.github.com/repos/mgba-emu/mgba/releases/latest version.json
RUN curl -s https://api.github.com/repos/mgba-emu/mgba/releases/latest | grep "browser_download_url.*download.*mGBA.*ubuntu64-focal.tar.xz" | cut -d : -f 2,3 | tr -d '"' | wget -qi - -O mGBA.tar.xz && \
  echo "Install FMD2" && \
  tar -xJvf mGBA.tar.xz -C /app && mv /app/mGBA* /app/mGBA && \
  mkdir /roms && \
  chown abc:abc -R /roms
RUN \
  dpkg -i /app/mGBA/libmgba.deb ; \
  apt -fy install && \
  dpkg -i /app/mGBA/mgba-qt.deb ; \
  apt -fy install

RUN \
  echo "Remove tools" && \
  rm mGBA.tar.xz && \
  apt auto-remove -y wget curl p7zip

RUN \
  rm /usr/share/novnc/vnc_lite.html /usr/share/novnc/vnc.html && \
  mkdir -p /mgba/ 

COPY index.html /usr/share/novnc/index.html
COPY mgba.sh /
COPY root/ /
COPY config.ini /mgba/

EXPOSE 6180
