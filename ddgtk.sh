#!/bin/bash

function menu 
{
	#Diálogo de inicio
	input=$(zenity --title="FutureLab DD GUI" --width=480 --text "Ingrese la fuente y el objetivo" --forms --add-entry "Fuente" --add-entry "objetivo")

	ret=$?

	#En caso de que el botón de inicio sea presionado el programa se terminará alv
	[[ $ret -eq 1]] && exit 0

	#Excepciones, ni yo confío en mis usuarios
}
