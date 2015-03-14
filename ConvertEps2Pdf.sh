#!/bin/bash
for dirpath in 'Simulation_Results_49rules' 'Simulation_Results_Gaussian_product' 'Simulation_Results_triangle_min'
  do
    if [ -x "$dirpath" ]
    then
      for epsname in `ls $dirpath`
        do
	  if [ ${epsname:(${#epsname}-4):${#epsname}} == '.eps' ]
	  then
            echo "In: "$dirpath"/"${epsname:0:${#epsname}-4}".eps"
            echo "Out: "$dirpath"/PdfFigure/"${epsname:0:${#epsname}-4}".pdf"
            if [ ! -x $dirpath"/PdfFigure/" ]
            then
              mkdir $dirpath"/PdfFigure/"
            fi
	     epstopdf -o=$dirpath"/PdfFigure/"${epsname:0:${#epsname}-4}".pdf" $dirpath"/"${epsname:0:${#epsname}-4}".eps"
             echo '----------'
           fi
	 done
     else
     echo "!!! Error: Direction "$dirpath" can not be found."
     fi
  done
