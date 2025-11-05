FROM scratch

ADD output/rootfs.tar /

WORKDIR /

CMD ["/bin/s6-svscan", "/etc/s6"]
