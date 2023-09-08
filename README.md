# lightburn-running-patch
If it happens to you that when you run the LightBurn software on GNU/Linux the default window layout is restored, this patch will serve you as much as it did me.

# The problem

The problem is that most of the time when you run LightBurn it restores the default layout, because the software "detects" (or reads the previous size from the config file) that the screen is too small to keep the changes we have made on it. the layout. Even if you have a monitor the size of an elephant.

# The cause
In LightBurn when you change the layout of the window, or the size of the window, those settings are saved in the file `$HOME/.config.LightBurn/prefs.ini`

But it happens that in GNU/Linux there are times that it saves the size of the window with negative measurements, I don't know why but they are always the same numbers:

     "WindowSizeX": -1,
     "WindowSizeY": -38,

I noticed that it usually happens when we DON'T make any changes to the window, either in layout or size. Although there are times that without making changes it saves the correct information. That's why I still don't understand the real cause.

# The solution
Since the problem is actually saving the wrong size, the solution is to change the value of the window in the configuration file before running LightBurn, always and forever...

That's why this patch does the following: with the jq command (to read the json configuration file) change the values to the correct ones, and then run the program.

# How to use
First of all check that the LightBurn installation folder is in the same place as it is in the `path_install.sh` script, otherwise change it to your system's.

     $HOME/.local/share/LightBurn

And the same should be verified for the `lightburn.desktop` file.

     $HOME/.local/share/applications/lightburn.desktop

If you need to modify it, do so in the script.

Download or clone the repository, and give permissions to the `patch_install.sh` file

     chmod +x patch_install.sh

then run it

     ./patch_install.sh

This will modify the original `lightburnsoftware.dektop` file so that it runs the `LightBurn.sh` file instead of the normal application. This file will change the erroneous values of the window and start LightBurn automatically.

# Mistakes
If the size allocated by the patch is not to your liking, modify it in the `LightBurn.sh` file and run the `patch_install.sh` script again.

     ./patch_install.sh

If you do not have the **jq** dependency installed, you will need to install it on your operating system, see the documentation here [jq installation documentation](https://jqlang.github.io/jq/download/)
But basically it would be something like this

### Linux
>jq is in the official Debian and Ubuntu repositories. Install using sudo apt-get install jq.

>jq is in the official Fedora repository. Install using sudo dnf install jq.

>jq is in the official openSUSE repository. Install using sudo zypper install jq.

>jq is in the official Arch repository. Install using sudo pacman -S jq.

### FreeBSD
>pkg install jq as root installs a pre-built binary package.

>make -C /usr/ports/textproc/jq install clean as root installs the jq port from source.

### Solaris
>pkgutil -i jq in OpenCSW for Solaris 10+, Sparc and x86.

### Windows
>Use winget to install jq with winget install jqlang.jq.

>Use scoop to install jq with scoop install jq.

>Use Chocolatey NuGet to install jq with chocolatey install jq.
