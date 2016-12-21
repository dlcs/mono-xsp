FROM centos

RUN yum -y install httpd httpd-devel make glib2-devel libpng-devel libjpeg-devel giflib-devel libtiff-devel libX11-devel gcc* fontconfig-devel bison gettext bzip2 libtool automake autoconf wget unzip cmake
RUN mkdir -p /opt/mono 
RUN wget --directory-prefix=/tmp http://download.mono-project.com/sources/mono/mono-4.8.0.382.tar.bz2
RUN wget --directory-prefix=/tmp http://download.mono-project.com/sources/xsp/xsp-4.2.tar.gz

RUN tar -xjf /tmp/mono-4.8.0.382.tar.bz2
RUN tar -xzf /tmp/xsp-4.2.tar.gz

RUN cd /mono-4.8.0 && ./configure --prefix=/opt/mono && make && make install

RUN export PATH=$PATH:/opt/mono/bin && export PKG_CONFIG_PATH=/opt/mono/lib/pkgconfig && cd /xsp-4.2 && ./configure --prefix=/opt/mono && make && make install

# Import root certificates
RUN /opt/mono/bin/mozroots --import --quiet --sync

