# Based on https://github.com/apnar/docker-image-nfs-ganesha
FROM phusion/baseimage:master
MAINTAINER v

# Add startup script
COPY start.sh /

# Install prerequisites
RUN DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y netbase nfs-common dbus nfs-ganesha nfs-ganesha-mem \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && mkdir -p /run/rpcbind /export /var/run/dbus \
 && touch /run/rpcbind/rpcbind.xdr /run/rpcbind/portmap.xdr \
 && chmod 755 /run/rpcbind/* \
 && chown messagebus:messagebus /var/run/dbus \
 && chmod +x /start.sh

# NFS ports and portmapper
EXPOSE 2049 38465-38467 662 111/udp 111

# Start Ganesha NFS daemon by default
CMD ["/start.sh"]
