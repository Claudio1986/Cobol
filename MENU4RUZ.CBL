       identification division.
       program-id. programa-principal.
       author. claudio-ruz.
       environment division.
       data division.
       working-storage section.
       01 opcion               pic x.
          88 ingreso-compra    value "1".
          88 ingreso-venta     value "2".
          88 stock-critico     value "3".
          88 med-vencidos      value "4".
          88 med-vendidos      value "5".
          88 salir             value "6".
       01 fecha-sys.
          02 s-ano             pic 99.
          02 s-mes             pic 99.
          02 s-dia             pic 99.
       01 fecha-programa.
          02 dia               pic 99.
          02 filler            pic x value "/".
          02 mes               pic 99.
          02 filler            pic x value "/".
          02 ano               pic 99.
       77 linea-subrayado      pic x(80) value all "*".
       screen section.
       01 pantalla-1
           background is blue foreground is green.
           02 pantalla-refresco
              blank screen
              reverse-video
              line 5 col 30 value is " MENU DE OPCIONES ".
           02 pantalla-fecha line 6 col 60
              foreground is white
              value is "FECHA:".
           02 filler col 68
              pic is x(8) using fecha-programa. 
           02 filer line 10 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 12 col 1
              foreground is yelow
              value "ENTRADA DE DATOS".
           02 opcion-1 line 14 col 1 foreground is red
              value is "opcion 1:".
           02 filler col 30
              value is "INGRESO DE COMPRAS DEL MEDICAMENTO".
           02 opcion-2 line 16 col 1 foreground is red
              value is "opcion 2:".
           02 filler col 30
              value is "INGRESO DE VENTAS DEL MEDICAMENTO".
           02 filler line 18 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 20 col 1
              foreground is WHITE
              value is "SECCION CONSULTAS".
           02 opcion-3 line 22 col 1 foreground is red
              value is "opcion 3:".
           02 filler col 30
              value is "CONSULTA DE MEDICAMENTOS BAJO STOCK CRITICO".
           02 opcion-4 line 24 col 1 foreground is red
              value is "opcion 4:".
           02 filler col 30
              value is "CONSULTA DE MEDICAMENTOS VENCIDOS".
           02 opcion-5 line 26 col 1 foreground is red
              value is "OPCION 5:".
           02 filler col 30
              value is "CONSULTA STOCK DE MEDICAMENTOS".
           02 filler line 28 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 30 col 1
              foreground is WHITE
              value is "SALIDA".
           02 opcion-6 line 34 col 1 foreground is red
              value is "opcion 6:".
           02 filler col 30
              value is "fin del programa".
           02 filler line 36 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 40 col 1 foreground is white
              value is "INGRESE OPCION :".
           02 filler line 42 col 1
              pic is x(80) using linea-subrayado.
       01 resultado.
           02 filler line 40 col 30
              pic is x using opcion required auto.	      
       procedure division.
       inicio.
       configurar-fecha.
           accept fecha-sys from date.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
       menu-principal.
           display pantalla-1.
           accept  resultado.
      
       opciones.
           if opcion not numeric then go menu-principal.
           if opcion < 1 or opcion > 6 then go menu-principal.
           if opcion = 1 then call "opcion1" using fecha-sys
              go inicio end-if
           if opcion = 2 then call "opcion2" using fecha-sys
              go inicio end-if
           if opcion = 3 then call "opcion3" using fecha-sys
              go inicio end-if
           if opcion = 4 then call "opcion4" using fecha-sys
              go inicio end-if
           if opcion = 5 then call "opcion5" using fecha-sys
              go inicio end-if
           
           if opcion = 6 then go fin.
       fin.
           stop run.


 
