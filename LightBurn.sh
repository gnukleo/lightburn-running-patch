#!/bin/sh

prefs_ini=$HOME/.config/LightBurn/prefs.ini

mv $prefs_ini $prefs_ini.old

echo "change values to windows sizes"
jq '.WindowSizeX=1834 | .WindowSizeY=968' $prefs_ini.old > $prefs_ini

if [ $# -eq 0 ]; then
    echo "run LightBurn without arguments.. "
    $HOME/.local/share/LightBurn/LightBurn
else
    echo "run LightBurn with arguments.. "
    $HOME/.local/share/LightBurn/LightBurn "$1"
fi
