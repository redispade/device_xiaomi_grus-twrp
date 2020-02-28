#!sbin/sh

#
# use ro.build.fingerprint,
# use ro.build.version.release, ro.build.version.security_patch, ro.vendor.build.security_patch
# from system/build.prop or vendor/build.prop instead of default.prop
#
# for noAB slot
# for BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
# for vendor/build.prop
# for keymaster-3.0+
#
# by wzsx150
# v3.0-20191029
#

SYSTEM_TMP=/tools/system_tmp
VENDOR_TMP=/tools/vendor_tmp

#systempart
for i in $(seq 0 90)
do
  systempart=`find /dev/block -name system | grep "by-name/system" -m 1 2>/dev/null`
  [ -z "$systempart" ] || break
  usleep 100000
done
[ -z "$systempart" ] && setprop "twrp.fingerprintid.prop" "0"
#[ -z "$systempart" ] && setprop "twrp.fingerprintid.system" "none"
[ -z "$systempart" ] && {
  touch /sbin/fingerprint_ready
  exit 1
}
#vendorpart
for i in $(seq 0 900)
do
  vendorpart=`find /dev/block -name vendor | grep "by-name/vendor" -m 1 2>/dev/null`
  [ -z "$vendorpart" ] || break
  usleep 1000
done


mkdir -p "$SYSTEM_TMP"
mkdir -p "$VENDOR_TMP"
mount -t ext4 -o ro "$systempart" "$SYSTEM_TMP"
mount -t ext4 -o ro "$vendorpart" "$VENDOR_TMP"
usleep 100

temp=`cat "$SYSTEM_TMP/system/build.prop" \
          "$SYSTEM_TMP/build.prop" \
          "$VENDOR_TMP/build.prop" \
          /default.prop 2>/dev/null`
usleep 100

umount "$SYSTEM_TMP" &
umount "$VENDOR_TMP" &

fingerprint=`echo "$temp" | grep -F "ro.build.fingerprint=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.fingerprint" "$fingerprint" &
sys_fingerprint=`echo "$temp" | grep -F "ro.system.build.fingerprint=" -m 1 | cut -d'=' -f2` && resetprop "ro.system.build.fingerprint" "$sys_fingerprint" &
RELEASE=`echo "$temp" | grep -F "ro.build.version.release=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.release" "$RELEASE" &
PATCH=`echo "$temp" | grep -F "ro.build.version.security_patch=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.security_patch" "$PATCH" &
SDK=`echo "$temp" | grep -F "ro.build.version.sdk=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.sdk" "$SDK" &
VENPATCH=`echo "$temp" | grep -F "ro.vendor.build.security_patch=" -m 1 | cut -d'=' -f2` && resetprop "ro.vendor.build.security_patch" "$VENPATCH" &


setprop "twrp.fingerprintid.prop" "1" &
setprop "twrp.fingerprintid.sys_root" "1" &
setprop "twrp.fingerprintid.system" "$systempart" &
setprop "twrp.fingerprintid.vendor" "$vendorpart" &

touch /sbin/fingerprint_ready

sleep 2

sys_fingerprint=`echo "$temp" | grep -F "ro.system.build.fingerprint=" -m 1 | cut -d'=' -f2`
RELEASE=`echo "$temp" | grep -F "ro.build.version.release=" -m 1 | cut -d'=' -f2`
[ -n "$sys_fingerprint" ] && [ "$RELEASE" -ge "10" ] && resetprop "ro.build.fingerprint" "$sys_fingerprint"

exit 0




