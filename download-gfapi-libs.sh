#!/bin/sh
# Download and extract libgfapi and supporting GlusterFS client libs

test -x /usr/bin/yumdownloader || {
  echo "install yum-utils / yumdownloader." 
  exit 1
}
yumdownloader glusterfs-libs glusterfs-api glusterfs
if [ $? != 0 ]; then
  echo "Download failed.  Retry."
  exit 2
fi
LIBRPM=`ls glusterfs-libs-*.x86_64.rpm`
echo "Found $LIBRPM, extracting:"
rpm2cpio $LIBRPM | cpio -idv
APIRPM=`ls glusterfs-api-*.x86_64.rpm`
echo "Found $APIRPM, extracting:"
APILIST=`rpm2cpio $APIRPM | cpio -t | grep -e libgfapi -e api.so`
rpm2cpio $APIRPM | cpio -idv $APILIST
XLATORRPM=`ls glusterfs-[0-9]*.x86_64.rpm`
XLATORLIST=`rpm2cpio $XLATORRPM | cpio -t | grep xlator`
rpm2cpio $XLATORRPM | cpio -idv $XLATORLIST
rm *.rpm
