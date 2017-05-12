FROM fedora:24
MAINTAINER @irix_jp

RUN dnf clean all \
 && dnf --setopt=deltarpm=false update -y \
 && dnf --setopt=deltarpm=false groupinstall -y "MATE Desktop" \
 && dnf --setopt=deltarpm=false install -y xrdp supervisor sudo which \
 && dnf clean all

RUN dnf --setopt=deltarpm=false install -y vim firefox emacs ibus-mozc \
 && dnf clean all

ADD supervisord.d/xrdp.ini  /etc/supervisord.d
ADD skel/                   /etc/skel/

RUN useradd fedora \
 && echo fedora:fedora | chpasswd \
 && echo "fedora   ALL=(ALL)   NOPASSWD: ALL" >> /etc/sudoers

EXPOSE 3389
CMD supervisord -n
