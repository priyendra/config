#! /bin/bash
# Usage: mount_lab_machines.sh (for mounting)
#        mount_lab_machines.sh -u (for unmounting)

if [ $# -eq 0 ]; then
  sshfs codemonkey@s004:/ /cluster/s004 &
  sshfs codemonkey@s005:/ /cluster/s005 &
  sshfs codemonkey@s006:/ /cluster/s006 &
  sshfs codemonkey@s007:/ /cluster/s007 &
  wait
  exit
fi

fusermount -u /cluster/s004
fusermount -u /cluster/s005
fusermount -u /cluster/s006
fusermount -u /cluster/s007
