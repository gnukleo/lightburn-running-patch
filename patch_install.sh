#!/bin/sh

# set app_dir and dektop_file variables, if your OS is an different location replace it
app_dir=$HOME/.local/share/LightBurn
desktop_file=$HOME/.local/share/applications/lightburn.desktop

# copy the launcher with patch top application dir
cp LightBurn.sh $app_dir/
# and set permission for execute
chmod +x $app_dir/LightBurn.sh 

# and then replace the original desktop file to use the launcher with the patch
sed 's#LightBurn/LightBurn$#LightBurn/LightBurn.sh#' $desktop_file > $desktop_file.new

# finnaly replace that file
mv $desktop_file.new $desktop_file

echo "Operation complete, please try now to open your app from menu or dash, or anywhere.."
echo "Check if there were any errors in the above output.."
