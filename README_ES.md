Si te sucede que cuando ejecutas el software LightBurn en GNU/Linux se reestablece el layout de la ventana por defecto, este parche te servirá tanto como a mi.

# El Problema

El problema es que la mayoria de las veces que ejecutas LightBurn se reestablece el layout por defecto, porque el software "detecta"  (o lee del archivo de configuracion el tamaño anterior) que la pantalla es demasiado pequeña para mantener los cambios que hemos echo en el layout. Aunque tengas un monitor del tamaño de un elefante.

# La Causa
En LightBurn cuando cambias el layout de la ventana, o el tamaño de la misma, se guarda esa configuración en el archivo `$HOME/.config.LightBurn/prefs.ini`

Pero sucede que en GNU/Linux hay veces que guarda el tamaño de la ventana con medidas en negativo, no se por que pero siempre son los mismos números:

    "WindowSizeX": -1,
    "WindowSizeY": -38,

Me di cuenta que generalmente sucede cuando NO hacemos ningun cambio en la ventana, tanto en el layout o el tamaño. Aunque hay veces que sin hacer cambios guarda la informacion correcta. Por eso no comprendo aun la causa real.

# La Solucion
Como en realidad el problema es que se guarda un tamaño equivocado, la solucion es cambiar el valor de la ventana en el archivo de configuracion antes de ejecutar LightBurn, siempre y por siempre...

Por eso este parche hace lo siguiente: con el comando jq (para leer el arhivo json de configuracion) cambia los valores por los correctos, y luego ejecuta el programa.

# Modo de uso
Antes que nada verifique que la carpeta de instalacion de LightBurn esta en el mismo lugar que figura en el script `path_install.sh` sino cambiela por la de su sistema.

    $HOME/.local/share/LightBurn

Y lo mismo debera verificar para el archivo `lightburn.desktop`

    $HOME/.local/share/applications/lightburn.desktop

Si necesita modificarlo hagalo en el script.

Descargue o clone el repositorio, y dele permisos al archivo `patch_install.sh`

    chmod +x patch_install.sh

Luego ejecutelo

    ./patch_install.sh

Esto modificara el archivo original `ligthburnsoftware.dektop` para que corra al archivo `LightBurn.sh` en vez de la aplicacion normal. Este archivo cambiara los valores erroneos de la ventana y ejecutara LightBurn automaticamente.

# Errores
Si el tamaño asignado por el parche no es de su agrado, modifiquelo en el archivo `LightBurn.sh` y vuelva a ejecutar el script `patch_install.sh`

    ./patch_install.sh

Si no tiene instalado la dependencia **jq** debera instalarla en su sistema operativo, vea la documentacion aqui [jq documentacion de instalacion](https://jqlang.github.io/jq/download/)
Pero basicamente seria algo como esto

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