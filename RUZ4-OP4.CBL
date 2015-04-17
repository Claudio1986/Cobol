       identification division.
       program-id. opcion-4.
       author. claudio-ruz.
       environment division.
       input-output section.
       file-control.

           select medicamentos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-medicamento.

           select prod-vencidos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-vencido.

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

       fd prod-vencidos
           label record is standard
           value of file-id is "vencidos.dat".
       01 reg-prodvencidos.
          02 codigo-vencido      pic x(6).
          02 descr-vencido       pic x(30).
          02 stock-vencido       pic 9(5).
          02 vfecha-compra.
             03 vdia-compra      pic 99.
             03 vmes-compra      pic 99.
             03 vano-compra      pic 99. 
          02 vfecha-elavoracion.
             03 vdia-elavoracion  pic 99.
             03 vmes-elavoracion  pic 99.
             03 vano-elavoracion  pic 99.
          02 vfecha-vencimiento.
             03 vdia-vencimiento  pic 99.
             03 vmes-vencimiento  pic 99.
             03 vano-vencimiento  pic 99.

       working-storage section.
       01 opcion                  pic x.
          88 registro-vencidos    value "1".
          88 vencidos-a-la-fecha  value "2".
       01 opcion-2                pic x.
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
              blank screen reverse-video line 4 col 25
              value is " consulta de medicamentos vencidos ".
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
       01 pantalla-opcion-1.
           02 filler line 10 col 1
              foreground is white
              value is "opcion 1:".
           02 filler col 20
              value is "ver registros de medicamentos vencidos".
           02 filler line 12 col 1
              foreground is white
              value is "opcion 2:".
           02 filler col 20
              value is
              "ver registro de medicamentos vencidos a la fecha de hoy".
           02 filler line 14 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 16 col 1
              foreground is white
              value is "ingrese opcion:".
           02 filler line 18 col 1
              pic is x(80) using linea-subrayado.
       01 respuesta-pantalla-opcion-1.
           02 filler line 16 col 20
              pic is x using opcion required auto. 

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
              pic is x(6) using codigo-vencido.
           02 filler line 24 col 1 foreground is white
              value is "descripcion:".
           02 filler col 30
              pic is x(30) using descr-vencido.
           02 filler line 26 col 1 foreground is white
              value is "stock vencido:".
           02 filler col 30
              pic is z(5) using stock-vencido.
           02 filler line 28 col 1 foreground is white
              value is "fecha de compra:".
           02 filler col 30
              pic is zz using vdia-compra.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is zz using vmes-compra.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is zz using vano-compra.
           02 filler line 30 col 1 foreground is white
              value is "fecha elavoracion:".
           02 filler col 30
              pic is zz using vdia-elavoracion.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is zz using vmes-elavoracion.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is zz using vano-elavoracion.
           02 filler line 8 col 1 foreground is white
              value is "fecha vencimiento:".
           02 filler col 30
              pic is zz using vdia-vencimiento.
           02 filler col 33 value is "/".
           02 filler col 34
              pic is zz using vmes-vencimiento.
           02 filler col 36 value is "/".
           02 filler col 37
              pic is zz using vano-vencimiento.
           02 filler line 34 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 36 col 1 foreground is green
              value is "ingrese 3 para: volver al menu principal".
           02 filler line 38 col 1
              pic is x(80) using linea-subrayado.
       01 pantalla-respuesta-informe.
           02 filler line 16 col 30
              pic is x using opcion-2 required auto.

       procedure division using fecha-sistema.
       inicio.
       ajustar-hora.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
       abrir-ficheros.
           open i-o medicamentos.
           open i-o prod-vencidos.
     
       leer-medicamentos.
           read medicamentos next record at end go comenzar.
           if ano > ano-vencimiento or ano = ano-vencimiento
              if mes > mes-vencimiento or mes = mes-vencimiento
                 if dia > dia-vencimiento or dia = dia-vencimiento
                    go grabar-registro-vencido
                 end-if
              end-if
           end-if.
           go leer-medicamentos.
       grabar-registro-vencido.
           move codigo-medicamento to codigo-vencido.
           move descr-medicamento  to descr-vencido.
           move cantidad-stock     to stock-vencido.
           move fecha-compra       to vfecha-compra.
           move fecha-elavoracion  to vfecha-elavoracion.
           move fecha-vencimiento  to vfecha-vencimiento.
           write reg-prodvencidos invalid key go mensaje-1.
     
       borrar-registro-vencido.
           start medicamentos key equal codigo-medicamento.
           delete medicamentos.
           close medicamentos.
           close prod-vencidos.
           open i-o medicamentos.
           open i-o prod-vencidos.
           go leer-medicamentos.
       comenzar.
           close medicamentos.
           close prod-vencidos.
           open input prod-vencidos.
       desplejar-pantalla-opcion-1.
           display pantalla-principal.
           display pantalla-opcion-1.
           accept  respuesta-pantalla-opcion-1.
    
       eleccion-1.
           if opcion not numeric then
              go desplejar-pantalla-opcion-1.
           if opcion < 1 or opcion > 2 then
              go desplejar-pantalla-opcion-1.
           if opcion = 1 then go registro-vencidos.
           if opcion = 2 then go vencidos-a-la-fecha.

       registro-vencidos.
       pantalla-informes.
           display pantalla-principal.
           display pantalla-informe.
           accept  pantalla-respuesta-informe.
      
       eleccion-2.
           if opcion-2 not numeric go eleccion-2.
           if opcion-2 < 1 or opcion-2 > 3 go eleccion-2.
           if opcion-2 = 1 then go anterior-registro.
           if opcion-2 = 2 then go siguiente-registro.
           if opcion-2 = 3 then go volver.
       anterior-registro.
           compute contador = contador - 1.
           read prod-vencidos previous record at end go volver.
           go pantalla-informes.
       siguiente-registro.
           add 1 to contador.
           read prod-vencidos next record at end go volver.
           go pantalla-informes.

       vencidos-a-la-fecha.
       pantalla-informes-2.
           display pantalla-principal.
           display pantalla-informe.
           accept  pantalla-respuesta-informe.
     
       eleccion-3.
           if opcion-2 not numeric go eleccion-3.
           if opcion-2 < 1 or opcion-2 > 3 go eleccion-3.
           if opcion-2 = 1 then go anterior-registro-2.
           if opcion-2 = 2 then go siguiente-registro-2.
           if opcion-2 = 3 then go volver.
       anterior-registro-2.
           compute contador = contador - 1.
           read prod-vencidos previous record at end go volver.
           if dia = dia-vencimiento then
              if mes = mes-vencimiento then
                 if ano = ano-vencimiento then
                    go pantalla-informes-2
                 end-if
              end-if
           end-if.
           move 1 to opcion-2.
           go eleccion-3.
       siguiente-registro-2.
           add 1 to contador.
           read prod-vencidos next record at end go volver.
           if dia = dia-vencimiento then
              if mes = mes-vencimiento then
                 if ano = ano-vencimiento then
                    go pantalla-informes-2
                 end-if
              end-if
           end-if.
           move 2 to opcion-2.
           go eleccion-3.

       volver.
           close prod-vencidos.
           goback.


       mensaje-1.
           display " " line 1 col 1 erase.
           display "no se puede grabar el registro".
           go volver.

           
