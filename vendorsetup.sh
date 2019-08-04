# apply libvintf patches
workdir=$(pwd)
cd system/libvintf || return
git reset -q --hard
[ "$target" == "grus" ] && patch --merge -sNp1 -i "$workdir"/device/xiaomi/grus/patches/system-libvintf-disable-vbmeta-check.patch
cd "$workdir" || return

add_lunch_combo omni_grus-eng
