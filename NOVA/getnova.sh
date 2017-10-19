#!/bin/sh

container=$(docker ps -aqf "ancestor=mariobarbareschi/nova-nre" -f "status=running")
nova_dir=$(cd `dirname $0` && pwd)

# Getting proper QEMU version (2.0.0)
if [[ -z $QEMU_BIN_x86_64 ]]; then
  QEMU_BIN_x86_64=qemu-system-x86_64
fi
if [[ -f $nova_dir/qemu/x86_64-softmmu/qemu-system-x86_64 ]]; then
  QEMU_BIN_x86_64=$nova_dir/qemu/x86_64-softmmu/qemu-system-x86_64
fi
if ! [[ $($QEMU_BIN_x86_64 -version) =~ 'version 2.0.0' ]]; then
  echo 'Copying and compiling QEMU 2.0.0'
  rm -fr $nova_dir/qemu/
  docker cp $container:/opt/qemu $nova_dir
  cd $nova_dir/qemu/
  ./configure --target-list=x86_64-softmmu
  make
  QEMU_BIN_x86_64=$nova_dir/qemu/x86_64-softmmu/qemu-system-x86_64
fi

# Moving compiled runtime environment outside
docker cp $container:/opt/NRE $nova_dir
cd $nova_dir/NRE/nre/build/x86_32-release
cd dist
rm -r imgs
ln -s ../../../dist/imgs imgs
cd ..

# $QEMU_BIN_x86_64 should be used if you need to specify an alternative path for qemu
$QEMU_BIN_x86_64 '-name' 'vmmng' '-m' '1024' '-smp' '4' '-netdev' 'user,id=mynet0' '-device' 'ne2k_pci,netdev=mynet0' '-cpu' 'phenom' '-kernel' 'bin/apps/hypervisor' '-append' 'spinner serial' '-initrd' 'bin/apps/root,bin/apps/acpi provides=acpi,bin/apps/keyboard provides=keyboard,bin/apps/reboot provides=reboot,bin/apps/pcicfg provides=pcicfg,bin/apps/timer provides=timer,bin/apps/console provides=console,bin/apps/network provides=network,bin/apps/sysinfo,bin/apps/vmmng mods=all lastmod,bin/apps/vancouver,dist/imgs/escape.bin,dist/imgs/escape_romdisk.bin,dist/imgs/escape_rtc.bin,dist/imgs/escape_fs.bin,dist/imgs/escape.iso,bin/apps/guest_munich,dist/imgs/bzImage-3.1.0-32,dist/imgs/initrd-js.lzma,dist/imgs/tinycore-vmlinuz,dist/imgs/tinycore-core.gz,escape.vmconfig,linux.vmconfig,tinycore-linux.vmconfig' '-serial' 'stdio'
