       identification division.
       program-id. opcion-3.
       author. claudio-ruz.
       environment division.
       configuration section.
       special-names.
           decimal-point is comma.
       input-output section.
       file-control.

           select medicamentos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-medicamento.

           select stock-critico assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-scritico.

       data division.
       file section.
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

       fd stock-critico
           label record is standard
           value of file-id is "scritico.dat".
       01 reg-stockcritico.
          02 codigo-scritico     pic x(6).
          02 descr-scritico      pic x(30).
          02 stock-scritico      pic 9(5).
          02 cfecha-compra.
             03 cdia-compra      pic 99.
             03 cmes-compra      pic 99.
             03 cano-compra      pic 99. 
          02 cfecha-elavoracion.
             03 cdia-elavoracion pic 99.
             03 cmes-elavoracion pic 99.
             03 cano-elavoracion pic 99.
          02 cfecha-vencimiento.
             03 cdia-vencimiento pic 99.
             03 cmes-vencimiento pic 99.
             03 cano-vencimiento pic 99. 

       working-storage section.
       01 opcion                  pic x.
          88 anterior             value "1".
          88 siguiente            value "2".
          88 volver               value "3".
       77 linea-subrayado         pic x(80) value all "_".
       77 contador                pic 9(5).
       01 fecha-programa.
          02 ano                  pic 99.
          02 mes                  pic 99.
          02 dia                  pic 99.

       linkage section.
       01 fecha-sistema.
          02 s-ano                pic 99.
          02 s-mes                pic 99.
          02 s-dia                pic 99.

       screen section.
       01 pantalla-principal
           background is blue foreground is red.
           02 pantalla-refresco
              blank screen
              reverse-video
              line 4 col 30 value is " stock critico ".
           02 pantalla-fecha line 6 col 60
              foreground is white
              value is "fecha:".
           02 filler col 68
              pic is 99 using dia.
           02 filler col 70 value is "-".
           02 filler col 71
              pic is 99 using mes.
           02 filler col 73 value is "-".
           02 filler col 74
              pic is 99 using ano.
           02 filler line 8 col 1 foreground is white
              pic is x(80) using linea-subrayado.
       01 pantalla-informe.
           02 filler line 10 col 1 foreground is green
              value is "ingrese 1 para:".
           02 filler line 12 col 1 foreground is green
              value is "<<< retroceder".
           02 filler line 10 col 62 foreground is green
              value is "ingrese 2 para:".
           02 filler line 12 col 62 foreground is green
              value ">>> avanzar".
           02 filler line 14 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 16 col 1 foreground is white
              value is "ingrese opcion:".
           02 filler line 18 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 20 col 1 foreground is white
              value is "registro numero:".
           02 filler col 30
              pic is z(5) using contador.
           02 filler line 22 col 1 foreground is white
              value is "codigo medicamento:".
           02 filler col 30 
              pic is x(6) using codigo-scritico.
           02 filler line 24 col 1 foreground is white
              value is "descripcion:".
           02 filler col 30
              pic is x(30) using descr-scritico.
           02 filler line 26 col 1 foreground is white
              value is "stock vencido:".
           02 filler col 30
              pic is z(4)9 using stock-scritico.
           02 filler line 28 col 1 foreground is white
              value is "fecha de compra:".
           02 filler col 30
              pic is 99 using cdia-compra.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is 99 using cmes-compra.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is 99 using cano-compra.
           02 filler line 30 col 1 foreground is white
              value is "fecha elavoracion:".
           02 filler col 30
              pic is 99 using cdia-elavoracion.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is 99 using cmes-elavoracion.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is 99 using cano-elavoracion.
           02 filler line 32 col 1 foreground is white
              value is "fecha vencimiento:".
           02 filler col 30
              pic is 99 using cdia-vencimiento.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is 99 using cmes-vencimiento.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is 99 using cano-vencimiento.
           02 filler line 34 col 1 
              pic is x(80) using linea-subrayado.
           02 filler line 36 col 1 foreground is green
              value is "ingrese 3 para: volver al menu principal".
           02 filler line 38 col 1
              pic is x(80) using linea-subrayado.
       01 respuesta-pantalla-informe.
           02 filler line 16 col 30
              pic is x using opcion required auto.
       
       procedure division using fecha-sistema.
       inicio.
           open input  medicamentos.
           open output stock-critico.
       ajustar-hora.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
     
       leer-medicamentos.
           read medicamentos next record at end go comenzar.
           if ano = ano-vencimiento then
              if mes-vencimiento + 1 = mes
                 go grabar-archivo-temporal
              end-if
              if mes-vencimiento + 2 = mes
                 go grabar-archivo-temporal
              end-if
           end-if.
           go leer-medicamentos.
     _
       grabar-archivo-temporal.
           move codigo-medicamento to codigo-scritico.
           move descr-medicamento  to descr-scritico.
           move cantidad-stock     to stock-scritico.
           move fecha-compra       to cfecha-compra.
           move fecha-elavoracion  to cfecha-elavoracion.
           move fecha-vencimiento  to cfecha-vencimiento.
           write reg-stockcritico invalid key go mensaje-1.
           close stock-critico.
           open i-o stock-critico.
           go leer-medicamentos.
       comenzar.
           close stock-critico.
           close medicamentos.
           open input stock-critico.
       desplejar-pantallas.
           display pantalla-principal.
           display pantalla-informe.
           accept  respuesta-pantalla-informe.
       eleccion.  
           if opcion not numeric then go desplejar-pantallas.
           if opcion < 1 or opcion > 3 then go desplejar-pantallas.
           if opcion = 1 then go anterior-registro.
           if opcion = 2 then go siguiente-registro.
           if opcion = 3 then go volver.
       anterior-registro.
           compute contador = contador - 1.
           read stock-critico previous record at end go volver.
           go desplejar-pantallas.
       siguiente-registro.
           add 1 to contador.
           read stock-critico next record at end go volver.
           go desplejar-pantallas.
       volver.
           close stock-critico.
           goback.


       mensaje-1.
           display " " line 1 col 1 erase.
           display "no se puede acceder al archivo" line 4 col 1.
           go volver.
 
