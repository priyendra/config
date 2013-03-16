#! /bin/bash
# Usage: mount_lab_machines.sh (for mounting)
#        mount_lab_machines.sh -u (for unmounting)

if [ $# -eq 0 ]; then
  sshfs sysadmin@s001:/ /cluster/s001 &
  sshfs sysadmin@s002:/ /cluster/s002 &
  sshfs sysadmin@s003:/ /cluster/s003 &
  sshfs sysadmin@s004:/ /cluster/s004 &
  sshfs sysadmin@s005:/ /cluster/s005 &
  sshfs sysadmin@s006:/ /cluster/s006 &
  sshfs sysadmin@s007:/ /cluster/s007 &
  wait
  exit
fi

fusermount -u /cluster/s001
fusermount -u /cluster/s002
fusermount -u /cluster/s003
fusermount -u /cluster/s004
fusermount -u /cluster/s005
fusermount -u /cluster/s006
fusermount -u /cluster/s007
