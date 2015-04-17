       identification division.
       program-id. opcion-1.
       author. claudio-ruz.
       environment division.
       input-output section.
       file-control.
       
           select factura-compra assign to disk
           organization is indexed
           access mode is dynamic
           record key is c-numero-factura.

           select laboratorio assign to disk
           organization is indexed
           access mode is dynamic
           record key is rut-laboratorio.

           select medicamentos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-medicamento.

       data division.
       file section.
       fd factura-compra
           label record is standard
           value of file-id "compras.dat".
       01 reg-factura.
          02 c-codigo-factura     pic x(6).
          02 c-numero-factura     pic x(6).
          02 c-rut-laboratorio    pic x(8).
       
       fd laboratorio
           label record is standard
           value of file-id "lab.dat".
       01 reg-laboratorio.
          02 rut-laboratorio      pic x(8).
          02 razon-social         pic x(15).
          02 dir-laboratorio      pic x(30).
          02 fono-laboratorio     pic x(10).
       
       fd medicamentos
           label record is standard
           value of file-id "medicamentos.dat".
       01 reg-medicamentos.
          02 codigo-medicamento  pic x(6).
          02 descr-medicamento   pic x(30).
          02 cantidad-stock      pic 9(5).
          02 precio-costo-u      pic 9(7).
          02 med-rut-laboratorio pic x(8).
          02 unidad-medida       pic x(2).
          02 cant-stock-critico  pic 9(5).
          02 fecha-elavoracion.
             03 dia-elavoracion  pic 99.
             03 mes-elavoracion  pic 99.
             03 ano-elavoracion  pic 99.
          02 fecha-vencimiento.
             03 dia-vencimiento  pic 99.
             03 mes-vencimiento  pic 99.
             03 ano-vencimiento  pic 99.
          02 fecha-compra.
             03 dia-compra       pic 99.
             03 mes-compra       pic 99.
             03 ano-compra       pic 99.
       
       working-storage section.
       01 opcion                   pic x.
          88 grabar-otro-registro  value "1".
          88 volver-menu-principal value "2".
       77 linea-subrayado          pic x(80) value all "_".
       77 numero-correlativo       pic 9(6)  value 0.
       01 fecha-programa.
          02 dia                   pic 99.
          02 filler                pic x value "/".
          02 mes                   pic 99.
          02 filler                pic x value "/".
          02 ano                   pic 99.
       linkage section.
       01 fecha-sistema.
          02 s-ano                 pic 99.
          02 s-mes                 pic 99.
          02 s-dia                 pic 99.
       screen section.
       01 pantalla-principal
           background is blue foreground is red.
           02 pantalla-refresco
              blank screen
              reverse-video
              line 4 col 25 value is "ingreso de factura de compra".
           02 pantalla-fecha line 6 col 60
              foreground is white
              value is "fecha:".
              02 filler col 68
              pic is x(8) using fecha-programa. 
       01 pantalla-factura.
           02 filler line 18 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "ingrese numero de la factura:".
           02 filler line 12 col 1
              foreground is white
              value is "ingrese rut del laboratorio:".
           02 filler line 14 col 1
              pic is x(80) using linea-subrayado.
       01 datos-factura.
           02 filler line 10 col 40
              pic is x(6) using c-numero-factura required auto.
           02 filler line 12 col 40
              pic is x(8) using c-rut-laboratorio required auto.
       01 pantalla-laboratorio.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.

           02 filler line 12 col 1
              foreground is white
              value is "ingrese direccion:".
           02 filler line 14 col 1
              foreground is white
              value is "ingrese fono:".
           02 filler line 16 col 1
              pic is x(80) using linea-subrayado.
       01 datos-laboratorio.
           02 filler line 10 col 40
              pic is x(15) using razon-social required auto.
           02 filler line 12 col 40
              pic is x(30) using dir-laboratorio required auto.
           02 filler line 14 col 40
              pic is x(10) using fono-laboratorio required auto.
       01 pantalla-medicamentos.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "ingrese codigo del medicamento:".
           02 filler line 12 col 1
              foreground is white
              value is "ingrese descripcion:".
           02 filler line 14 col 1
              foreground is white
              value is "ingrese cantidad:".
           02 filler line 16 col 1
              foreground is white
              value is "ingrese precio costo unitario:".
           02 filler line 18 col 1
              foreground is white
              value is "ingrese unidad de medida:".
           02 filler line 20 col 1
              foreground is white
              value is "ingrese fecha de elavoracion (dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 22 col 1
              foreground is white
              value is "ingrese fecha de vencimiento (dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 24 col 1
              foreground is white
              value is "ingrese fecha de compra      (dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 26 col 1
              pic is x(80) using linea-subrayado.
       01 datos-pantalla-medicamentos.
           02 filler line 10 col 50
              pic is x(6) using codigo-medicamento required auto.
           02 filler line 12 col 50
              pic is x(30) using descr-medicamento required auto.
           02 filler line 14 col 50
              pic is 9(5) using cantidad-stock required auto.
           02 filler line 16 col 50
              pic is 9(7) using precio-costo-u required auto.
           02 filler line 18 col 50
              pic is xx using unidad-medida required auto.
           02 filler line 20 col 50
              pic is 99 using dia-elavoracion required auto.
           02 filler col 53
              pic is 99 using mes-elavoracion required auto.
           02 filler col 56
              pic is 99 using ano-elavoracion required auto.
           02 filler line 22 col 50
              pic is 99 using dia-vencimiento required auto.
           02 filler col 53
              pic is 99 using mes-vencimiento required auto.
           02 filler col 56
              pic is 99 using ano-vencimiento required auto.
           02 filler line 24 col 50
              pic is 99 using dia-compra required auto.
           02 filler col 53
              pic is 99 using mes-compra required auto.
           02 filler col 56
              pic is 99 using ano-compra required auto.
       01 pantalla-pregunta.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "opcion 1:".
           02 filler col 25
              value is "agregar otro medicamento a la factura".
           02 filler line 12 col 1
              foreground is white
              value is "opcion 2:".
           02 filler col 25
              value is "grabar registro y volver al menu principal".
           02 filler line 14 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 16 col 1
              foreground is white
              value is "ingrese opcion".
           02 filler line 18 col 1
              pic is x(80) using linea-subrayado.
       01 opcion-pantalla-pregunta.
           02 filler line 16 col 25
              pic is x using opcion required auto.
       procedure  division using fecha-sistema.
       inicio.
       ajustar-fecha.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
       abrir-ficheros.
           open i-o factura-compra.
           open i-o laboratorio.
           open i-o medicamentos.
       desplejar-pantalla-principal.
           display pantalla-principal.
     
       fijar-codigo-factura-compra.
           read factura-compra next record at end go codigo-factura.
           add 1 to numero-correlativo.
           go fijar-codigo-factura-compra.
       codigo-factura.
           add 1 to numero-correlativo.
           close factura-compra.
           open i-o factura-compra.
       desplejar-pantalla-factura.
           display pantalla-factura.
           accept  datos-factura.
       grabar-registro-factura.
           move numero-correlativo to c-codigo-factura.
           move 0 to numero-correlativo.
           write reg-factura invalid key go mensaje-1.
      
       buscar-rut-laboratorio.
           read laboratorio next record
           at end go desplejar-pantalla-laboratorio.
           if  c-rut-laboratorio = rut-laboratorio then
               go pantalla-medicamentos end-if
           go buscar-rut-laboratorio.
       desplejar-pantalla-laboratorio.   
           display pantalla-principal.
           display pantalla-laboratorio.
           accept  datos-laboratorio.
       grabar-registro-laboratorio.
           move c-rut-laboratorio to rut-laboratorio.
           write reg-laboratorio invalid key go mensaje-2.
       pantalla-medicamentos.
           display pantalla-principal.
           display pantalla-medicamentos.
           accept  datos-pantalla-medicamentos.
       grabar-registro-medicamento.
           move rut-laboratorio to med-rut-laboratorio.
           move 0               to cant-stock-critico.
           write reg-medicamentos invalid key go mensaje-3.
      
       desplejar-pantalla-pregunta.   
           display pantalla-principal.
           display pantalla-pregunta.
           accept  opcion-pantalla-pregunta.
           if opcion not numeric then go desplejar-pantalla-pregunta.
           if opcion < 1 or opcion > 2 then
              go desplejar-pantalla-pregunta.
           if opcion = 1 then
              close medicamentos
              open i-o medicamentos
              go pantalla-medicamentos end-if.
           if opcion = 2 then go volver.

       volver.
           close medicamentos.
           close laboratorio.
           close factura-compra.
           goback.


       mensajes.
       mensaje-1.
           display " " line 1 erase.
           display "no se puede actulizar el dato" line 4 col 1.
           go volver.
       mensaje-2.
           display " " line 1 erase.
           display "no se puede grabar el dato" line 4 col 1.
           go volver.
       mensaje-3.
           display " " line 1 erase.
           display "este codigo ya existe" line 4 col 1.
           go volver. 
