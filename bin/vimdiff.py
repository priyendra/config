#!/usr/bin/python

import sys
import os

def main(args):
  cmd = 'vim -R -f -c "source /home/deshwal/bin/vimdiff.vim"'
  #cmd = ''
  cmd += ' -c "DirDiff %s %s"' % (args[0], args[1])
  cmd += ' -c "wincmd t"'
  os.system(cmd)

if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
