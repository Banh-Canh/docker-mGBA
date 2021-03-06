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
  echo "Install mGBA" && \
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
  apt auto-remove -y wget p7zip

RUN \
  rm /usr/share/novnc/vnc.html && \
  mv /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html && \
  curl https://raw.githubusercontent.com/novnc/noVNC/master/vnc_lite.html > /usr/share/novnc/index.html && \
  sed -i '42s/.*/display:none;/' /usr/share/novnc/index.html && \
  sed -i '50s/.*/display:none;/' /usr/share/novnc/index.html && \
  sed -i '169s/.*/rfb.scaleViewport = readQueryVariable("scale", true);/' /usr/share/novnc/index.html && \
  mkdir -p /mgba/ 

ADD fluxbox /fluxbox
COPY mgba.sh /
COPY root/ /
COPY config.ini /mgba/

EXPOSE 6180
