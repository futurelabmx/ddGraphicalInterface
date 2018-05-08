#!/bin/bash

function menu 
{
	#Diálogo de inicio
	input=$(zenity --title="FutureLab DD GUI" --width=480 --text "Ingrese la fuente y el objetivo" --forms --add-entry "Fuente" --add-entry "objetivo")

	ret=$?

	#En caso de que el botón de inicio sea presionado el programa se terminará alv
	[[ $ret -eq 1]] && exit 0

	#Excepciones, ni yo confío en mis usuarios
if [ -z "$(echo $input | awk 'BEGIN {FS="|" } { print $1 }')" ]; then
	zenity --width=560 --warning="No se especificó una fuente" --text="<b> No se especificó una fuente.</b>\n\n Pedazo de gil, que no se te olvide otra vez por favor. EX: /dev/sr0\n\n Regresar al menú ..."
	menu
fi

# De nuevo, no confío en mis usuarios
if [ -z "$(echo $input | awk 'BEGIN {FS="|" } { print $2 }')" ]; then
	zenity --width=560 --warning="No se especificó un objetivo" --text="<b> No se especificó un objetivo.</b>\n\n Claramente no sabes leer, ahora corrige tu cagadero. EX: /home/$USER/movie.iso\n\n Regresar al menú ..."
	menu
fi

}
menu

# Esta madre es para que el pipe no estorbe
SOURCE=$(echo $input | awk 'BEGIN {FS="|" } { print $1 }')
TARGET=$(echo $input | awk 'BEGIN {FS="|" } { print $2 }')

export SOURCE
export TARGET

# Por si la cagan.
zenity --info --width=560 --height=40 --title="Iniciando .. " --timeout 2 --text="<b> Estoy trabajando ...  Por favor espera y no la cagues, porque no repararé tu memoria ..... </b>"

# Mostrar una barra de progreso (Gracias StackOverflow)
dd if=$SOURCE of=$TARGET 2>&1 | zenity --width=560 --progress --title="Haciendo un cagadero ... " --text="<b><span color=\"blue\"> La operación está en proceso .....    Aguante las carnes .....</span></b>" --percentage=0 --pulsate --no-cancel --auto-kill --auto-close

# Si junció.
zenity --info --width=560 --title="Fin .. " --timeout 20 --text="<b>éxito:</b><span color=\"blue\">  La operación se completó correctamente.</span> \n\n<b>Source: $SOURCE    ------>    Target: $TARGET</b>"

exit 0
# Aqui se acapa el mingorote
}
