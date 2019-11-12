# TODO use a makefile instead
BUILDDIR=${BUILDDIR:-$PWD/build}
INSTALLDIR=${INSTALLDIR:-$PWD/install}

# latest longterm kernel, change this if you want to user a different kernel version
KERNEL_VERSION="4.19.83"
KERNEL_MAJOR_VERSION=`echo $KERNEL_VERSION | grep -o "^[^.]"`
KERNEL_SOURCE_URL=${KERNEL_SOURCE_URL:-"https://cdn.kernel.org/pub/linux/kernel/v$KERNEL_MAJOR_VERSION.x/linux-$KERNEL_VERSION.tar.xz"}
KERNEL_SOURCE_PGP=`echo $KERNEL_SOURCE_URL | sed "s/xz$/sign/"`

# download the kernel source
mkdir -p $BUILDDIR
cd $BUILDDIR &&
#wget $KERNEL_SOURCE_URL &&
#wget $KERNEL_SOURCE_PGP &&
tar xJf linux-$KERNEL_VERSION.tar.xz &&
# TODO verify signature
cd linux-$KERNEL_VERSION &&
# TODO automate config
(make ARCH=um oldconfig || make ARCH=um menuconfig) &&
make -j$(nproc) ARCH=um &&

cd $BUILDDIR &&
wget --convert-links -O alpinerelease.html http://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/ &&
ROOTFS_URL=`grep -o "http://[^\"]*minirootfs[^\"]*tar.gz" alpinerelease.html | sort | tail -n 1` &&
wget $ROOTFS_URL -O rootfs.tgz &&
mkdir rootfs &&
cd rootfs &&
tar xf ../rootfs.tgz &&
# TODO


# install the system TODO
mkdir -p $INSTALLDIR &&
cp $BUILDDIR/linux-$KERNEL_VERSION/linux $INSTALLDIR
