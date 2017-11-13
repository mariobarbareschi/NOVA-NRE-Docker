#!/bin/sh

if [ ! "$(ls -A /mnt/NRE)" ]; then
  echo "[nresync] Found empty NRE directory in host system. Copying sources..."
  rsync -a /src/NRE/ /mnt/NRE
  chmod 777 -R /mnt/NRE 
 echo "[nresync] Done."
elif [ "$(diff -x .git -r /mnt/NRE /src/NRE)" ]; then
  echo "[nresync] Found updated NRE directory in host system. Applying changes..."
  rsync -av /mnt/NRE/ /opt/NRE
  echo "[nresync] Done."
else
  echo "[nresync] Same host and container NRE directory. No changes need to be applied."
fi
cd /opt/NRE/nre
