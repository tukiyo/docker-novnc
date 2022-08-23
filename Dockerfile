FROM ubuntu:22.04

ENV \
  DEBIAN_FRONTEND=noninteractive \
  DISPLAY=:0 \
  LANG="ja_JP.UTF-8" \
  LANGUAGE="ja_JP:ja" \
  LC_ALL="ja_JP.UTF-8" \
  TZ="Asia/Tokyo"

RUN sed -i -e 's/archive/jp.archive/g' /etc/apt/sources.list
RUN echo 'apt update && apt install --no-install-recommends -y $@ && apt-get clean && rm -rf /var/lib/apt/lists/*' > /usr/local/bin/pkgadd \
 && chmod +x /usr/local/bin/pkgadd

RUN pkgadd locales tzdata \
 && sed -i -e "s/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" /etc/locale.gen \
 && dpkg-reconfigure locales \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && dpkg-reconfigure tzdata \
 && mkdir -p ~/.config \
 && echo "LC_CTYPE=ja_JP.UTF-8" >> ~/.config/locale.conf

RUN pkgadd novnc xvfb supervisor x11vnc net-tools sudo

RUN pkgadd fonts-ipafont
RUN pkgadd icewm xfce4-terminal
RUN pkgadd language-pack-ja
RUN pkgadd vim ranger

RUN pkgadd ssh autossh tig expect xtightvncviewer rdesktop screen

# brave-browser
RUN pkgadd apt-transport-https
RUN wget -O "/usr/share/keyrings/brave-browser-archive-keyring.gpg" "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
RUN pkgadd brave-browser

# nginx
RUN pkgadd nginx
COPY files/nginx/htpasswd /etc/nginx/htpasswd
COPY files/nginx/default /etc/nginx/sites-available/default

ENV \
  SCREEN=0 \
  SCREEN_WIDTH=1280 \
  SCREEN_HEIGHT=900 \
  SCREEN_DEPTH=24

# ユーザーを作成
ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
 && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd \
 && echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && echo "Set disable_coredump false" >> /etc/sudo.conf

USER ${DOCKER_USER}
ENV DOCKER_USER=${DOCKER_USER}
ENV URL="https://google.co.jp"

COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY files/novnc.html /usr/share/novnc/index.html

# vnc
EXPOSE 5900
# novnc
EXPOSE 6080
# nginx with auth
EXPOSE 80
CMD ["sudo", "-E", "/usr/bin/supervisord"]
