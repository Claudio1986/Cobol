       identification division.
       program-id. opcion-5.
       author. claudio-ruz.
       environment division.
       input-output section.
       file-control.
	   
           select clientes assign to disk
           organization is indexed
           access mode is dynamic
           record key is rut-cliente.

           select movimiento-medicamento assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-movimiento.

       data division.
       file section.

       fd clientes
           label record is standard
           value of file-id "clientes.dat".
       01 reg-clientes.
          02 rut-cliente          pic 9(8).
          02 dv-cliente           pic x.
          02 apellido-cliente     pic x(20).
          02 nombre-cliente       pic x(20).
          02 dir-cliente          pic x(30).
          02 fono-cliente         pic x(10).

       fd movimiento-medicamento
           label record is standard
           value of file-id "mov.dat".
       01 reg-movimiento.
          02 codigo-movimiento     pic x(6).
          02 num-factura           pic x(6).
          02 cantidad-movimiento   pic 9(5).
          02 v-fecha-elavoracion.
             03 v-dia-elavoracion  pic 99.
             03 v-mes-elavoracion  pic 99.
             03 v-ano-elavoracion  pic 99.
          02 v-fecha-vencimiento.
             03 v-dia-vencimiento  pic 99.
             03 v-mes-vencimiento  pic 99.
             03 v-ano-vencimiento  pic 99.
          02 fecha-venta.
             03 dia-venta         pic 99.
             03 mes-venta         pic 99.
             03 ano-venta         pic 99.
          02 descripcion-mov      pic x(30).
          02 precio-costo-mov     pic 9(7).
          02 rut-cliente-mov      pic x(8).
          02 unidad-med-mov       pic x(2).

       working-storage section.
       01 opcion                  pic x.
          88 anterior             value "1".
          88 siguiente            value "2".
          88 volver               value "3".
       01 fecha-programa.
          02 dia               pic 99.
          02 filler            pic x value "/".
          02 mes               pic 99.
          02 filler            pic x value "/".
          02 ano               pic 99.
       77 linea-subrayado      pic x(80) value all "_".
       77 contador             pic 9(5).

       linkage section.
       01 fecha-sistema.
          02 s-ano                 pic 99.
          02 s-mes                 pic 99.
          02 s-dia                 pic 99.

       screen section.
       01 pantalla-principal
           background is blue foreground is cyan.
           02 pantalla-refresco
              blank screen
              reverse-video
              line 1 col 25 value is " registro stock medicamentos".
           02 pantalla-fecha line 2 col 60
              foreground is white
              value is "fecha:".
              02 filler col 68
              pic is x(8) using fecha-programa. 
       
       01 pantalla-informe.
           02 filer line 8 col 1
              pic is x(80) using linea-subrayado. 
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
       01 pantalla-informe-factura.
           02 filler line 22 col 1 foreground is white
              value is "numero factura:".
           02 filler col 30
              pic is z(5) using contador.
       01 pantalla-informe-cliente.
           02 filler line 24 col 1 foreground is white
              value is "rut cliente".
           02 filler col 30
              pic is z(8) using rut-cliente.
           02 filler col 38 value is "-".
           02 filler col 39
              pic is x using dv-cliente.
           02 filler line 26 col 1 foreground is white
              value is "apellido cliente:".
           02 filler col 30
              pic is x(20) using apellido-cliente.
           02 filler line 28 col 1 foreground is white
              value is "nombre cliente:".
           02 filler col 30
              pic is x(20) using nombre-cliente.
           02 filler line 30 col 1 foreground is white
              value is "direccion:".
           02 filler col 30
              pic is x(30) using dir-cliente.
           02 filler line 32 col 1 foreground is white
              value is "fono:".
           02 filler col 30
              pic is x(10) using fono-cliente.
       01 pantalla-informe-movimiento.
           02 filler line 34 col 1 foreground is white
              value is "codigo medicamento:".
           02 filler col 30
              pic is z(6) using codigo-movimiento.
           02 filler line 36 col 1 foreground is white
              value is "descripcion".
           02 filler col 30
              pic is x(30) using descripcion-mov.
           02 filler line 38 col 1 foreground is white
              value is "precio costo unitario".
           02 filler col 30
              pic is z(7) using precio-costo-mov.
           02 filler line 40 col 1 foreground is white
              value is "unidad de medida:".
           02 filler col 30
              pic is xx using unidad-med-mov.
           02 filler line 42 col 1 foreground is white
              value is "cantidad del movimiento:".
           02 filler col 30
              pic is z(5) using cantidad-movimiento.
           02 filler line 44 col 1 foreground is white
              value is "fecha de venta:".
           02 filler col 30
              pic is zz using dia-venta.
           02 filler col 32 value is "/".
           02 filler col 33
              pic is zz using mes-venta.
           02 filler col 35 value is "/".
           02 filler col 36
              pic is zz using ano-venta.
           02 filler line 46 col 1
              pic is x(80) using linea-subrayado.
           02 filler line 48 col 1 foreground is green
              value is "ingrese 3 para:".
           02 filler col 30 foreground is green
              value is "volver al menu principal".
           02 filler line 50 col 1
              pic is x(80) using linea-subrayado.

       01 opcion-pantalla-informe.
           02 filler line 7 col 30
              pic is x using opcion required auto.
	   
       procedure division using fecha-sistema.
       inicio.
       ajustar-fecha.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
       abrir-ficheros.
           open input clientes.
           open input movimiento-medicamento.
       desplejar-pantallas.
           display pantalla-principal.
           display pantalla-informe.
           display pantalla-informe-factura.
           display pantalla-informe-cliente.
           display pantalla-informe-movimiento.
           accept opcion-pantalla-informe.
       eleccion.
           if opcion not numeric then go desplejar-pantallas.
           if opcion < 1 or opcion > 3 then go desplejar-pantallas.
           if opcion = 1 then go anterior-registro.
           if opcion = 2 then go siguiente-registro.
           if opcion = 3 then go volver.
       anterior-registro.
           compute contador = contador - 1.
           read movimiento-medicamento previous record
           at end go volver.
           go recuperar-datos.
       siguiente-registro.
           add 1 to contador.
           read movimiento-medicamento next record
           at end go volver.
           go recuperar-datos.
       
       recuperar-datos.
       buscar-cliente.
           move rut-cliente-mov to rut-cliente.
           start clientes key equal rut-cliente.
           read clientes.
           go desplejar-pantallas.
       volver.
           move 0 to contador.
           close clientes.
           close movimiento-medicamento.
           goback.
           


       



	    
