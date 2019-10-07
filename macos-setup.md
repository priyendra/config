### Install brew
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install git
```
$ brew install git
```

### Fetch the config repository
```
$ cd
$ mkdir -p work
$ cd work
$ git clone https://github.com/priyendra/config.git
```

### Install and setup iterm2
The next few steps are manual
- Install latest iterm2
- Point iterm2 to read/write config to ~/work/config/iterm2-config
- This can be done under iTerm2 > Preferences > General > Preferences.

### Upgrade to latest version of bash
```
$ brew install bash
$ sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
$ chsh -s /usr/local/bin/bash
$ sudo /sbin/reboot
```

### Install config files
```
$ cd ~/work/config
$ ./bin/install_config.sh
```

### Ssh configuration
- Potentially copy ~/work/config/ssh-config to ~/.ssh/config
- Add ssh keys etc to github.com/gitlab.com etc

### Fuzzy finder
```
$ brew install fzf
$ /usr/local/opt/fzf/install
```

### Tmux

```
$ brew install tmux
```

### Other steps
- Install Google Chrome, Moom (from App Store), Karabiner Elements
- In Moom, setup the keyboard shortcut
- In Karabiner Elements, map Caps Lock to Escape and map right cmd + hjkl
  to arrow keys
