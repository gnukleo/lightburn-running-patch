#!/bin/sh

prefs_ini=$HOME/.config/LightBurn/prefs.ini

mv $prefs_ini $prefs_ini.old

echo "change values to windows sizes"
jq '.WindowSizeX=1834 | .WindowSizeY=968' $prefs_ini.old > $prefs_ini

echo "run LightBurn.."
$HOME/.local/share/LightBurn/LightBurn "$1"
