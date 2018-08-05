#!/bin/bash
if [ $# -eq 0 ] #verifica que exista un archivo de entrada
  then
    echo "No arguments supplied"
    exit 1
fi
if [ "$#" -ne 1 ];then # verifica que solo sea 1 archivo de entrada
	echo "Solo puede haber 1 parametro de entrada"
	exit 1
fi
input=$@ # archivo de entrada
b=${input%%.*} # split si el archivo contiene un punto
c=$b".java" # concatena b con .java
d=$(find -name $input | wc -l) #  verifica existencia del archivo en el directorio actual
e=$(find -name $c | wc -l) # verifica existencia del archivo .java en el directorio actual
if [ "$d" -eq "1" ]; then # verifica si existe el archivo en el directorio actual
        #echo "si existe el archivo en el directorio actual"
        if [ "$e" -eq "1" ];then # verifica si existe el arc .java en el directorio actual
               # echo "si es un archivo .java"
		#echo $input
		javac -Xstdout output.txt $input # compilo el archivo.java
		v=$(cat output.txt | grep "error" | wc -l) # verifico que no se haya generado error de compilacion
		rm output.txt	# elimino el archivo de verificacion de error de compilacion
		if [ "$v" -eq "0" ];then # verifico que no se haya generado error de compilacion
		        #echo "No error de compilacion"
		        executeFile=$b
		        #echo "executeFile: "$executeFile
		        java $executeFile # ejecuto el archivo compilado
		else
		        echo "Se genero erro de compilacion"
		        exit 1
		fi
		rm $b".class" #elimino el archivo compilado
        else
                #echo "no es un achivo .java"
		exit 1
        fi
else
        echo "No existe el archivo en el directorio actual"
	exit 1
fi
