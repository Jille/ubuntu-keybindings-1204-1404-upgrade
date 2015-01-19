#!/bin/bash

# Delete old new-style keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

gconftool-2 -R /desktop/gnome/keybindings | while read LINE; do
	read BINDINGLINE
	read ACTIONLINE
	read NAMELINE
	NUM="`echo "$LINE" | sed -e 's@^/desktop/gnome/keybindings/custom@@g' -e 's/:$//g'`"
	BINDING="`echo "$BINDINGLINE" | sed 's/^binding = //g'`"
	ACTION="`echo "$ACTIONLINE" | sed 's/^action = //g'`"
	NAME="`echo "$NAMELINE" | sed 's/^name = //g'`"


	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$NUM/ name "'$NAME'"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$NUM/ command "'$ACTION'"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$NUM/ binding "'$BINDING'"
	CURRENTLIST="`gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings`"
	CURRENTLIST="${CURRENTLIST%]}, '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$NUM/']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${CURRENTLIST/[, /[}"
done
