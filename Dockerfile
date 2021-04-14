FROM debian:bullseye-slim
LABEL maintainer="Jakub Dubec <jakub.dubec@gmail.com>"

# Dependencies
WORKDIR /tmp
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential git libpcap-dev curl
RUN ["curl", "http://archive.debian.org/debian//pool/main/libn/libnet0/libnet0_1.0.2a-7_amd64.deb", "-o", "libnet0.deb"]
RUN ["dpkg", "-i", "libnet0.deb"]
RUN ["curl", "http://archive.debian.org/debian//pool/main/libn/libnet0/libnet0-dev_1.0.2a-7_amd64.deb", "-o", "libnet0-dev.deb"]
RUN ["dpkg", "-i", "libnet0-dev.deb"]


# Clone repository
WORKDIR /opt
RUN git clone https://github.com/alanackart/DDOSIM.git ddosim
WORKDIR /opt/ddosim

# Build
RUN ["chmod", "+x", "configure"]
RUN ["./configure"]
RUN make
RUN make install
