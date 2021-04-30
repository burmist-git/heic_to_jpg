#!/bin/bash

function convert_HEIC_to_jpg_sh {
    for file in $1/*.HEIC; do heif-convert $file ${file/%.HEIC/.jpg}; done
    #for file in $1/*.HEIC; do echo $1; done
    #for file in $1/*.HEIC; do echo "$file ${file/%.HEIC/.jpg}"; done
}

function transform_names {

    for filen in $1/*.jpg; do
	text=`file $filen`
	#Set comma as delimiter
	IFS=','
	read -a strarr <<< "$text"
	datetime=`echo "${strarr[15]}" | grep datetime | sed 's/datetime=//g' | sed 's/ /_/g' | sed 's/:/-/g'`
	datetime_lenght=`echo $datetime | wc -c`
	if [ $datetime_lenght -gt 10 ]; then
	    echo "filen           = $filen"
	    mv $filen ${filen/%.jpg/''}$datetime.jpg
	    #echo "datetime        = $datetime"
	    #echo "datetime_lenght = $datetime_lenght"
	fi
    done
    
}

function printHelp {
    echo " --> ERROR in input arguments"
    echo " -h       : print help"
    echo " --conv   : convert HEIC to jpg"
    echo "    [1]   : dirrectory name"
    echo " --trname : transform names"
    echo "    [1]   : dirrectory name"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-h" ]; then
        printHelp
    elif [ "$1" = "--conv" ]; then
        if [ $# -eq 2 ]; then
            convert_HEIC_to_jpg_sh $2
        else
            printHelp
        fi
    elif [ "$1" = "--trname" ]; then
        if [ $# -eq 2 ]; then
            transform_names $2
        else
            printHelp
        fi
    else
        printHelp
    fi
fi

