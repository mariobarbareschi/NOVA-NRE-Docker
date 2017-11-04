#!/bin/sh

if [ ! "$(ls -A /mnt/NRE)" ]; then
  echo "Found empty NRE directory in host system. Copying sources..."
  rsync -a /src/NRE/ /mnt/NRE
  echo "Done."
else
  echo "Syncing NRE directory..."
  rsync -av /mnt/NRE/ /opt/NRE
  echo "Done."
fi
cd $NRE_PATH