#!/usr/bin/env bash

# http://superuser.com/questions/244189/bashrc-how-to-know-x-window-is-available-or-not
if [ -n "$DISPLAY" ]; then
    # gsettings get com.canonical.Unity.Launcher favorites
    echo "==> Set Unity launcher items"
    gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'unity://running-apps', 'application://gnome-system-monitor.desktop', 'unity://expo-icon', 'unity://devices']"

    # http://askubuntu.com/questions/177348/how-do-i-disable-the-screensaver-lock
    echo "==> Disable unity lock screen"
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0 # (0 to disable)

    # http://askubuntu.com/questions/79150/how-to-remove-bookmarks-from-the-nautilus-sidebar/152540#152540
    echo "enabled=false" > $HOME/.config/user-dirs.conf

    sed -i 's/\Documents//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Downloads//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Music//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Pictures//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Public//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Templates//' $HOME/.config/user-dirs.dirs
    sed -i 's/\Videos//' $HOME/.config/user-dirs.dirs

    rm -fr $HOME/Documents
    rm -fr $HOME/Downloads
    rm -fr $HOME/Music
    rm -fr $HOME/Pictures
    rm -fr $HOME/Public
    rm -fr $HOME/Templates
    rm -fr $HOME/Videos

    mkdir -p $HOME/.config/gtk-3.0/
    echo > $HOME/.config/gtk-3.0/bookmarks
else
    echo "This script should be execute inside a GUI terminal"
fi
