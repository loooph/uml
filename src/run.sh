linux \
    root=/dev/root \
    rootfstype=hostfs \
    rootflags=$PWD/rootfs \
    rw \
    mem=64M \
    init=/bin/sh
