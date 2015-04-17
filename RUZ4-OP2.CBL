       identification division.
       program-id. opcion-2.
       author. claudio-ruz.
       environment division.
       configuration section.
       special-names.
           decimal-point is comma.
       input-output section.
       file-control.

           select factura-venta assign to disk
           organization is indexed
           access mode is dynamic
           record key is v-numero-factura.

           select clientes assign to disk
           organization is indexed
           access mode is dynamic
           record key is rut-cliente.

           select movimiento-medicamento assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-movimiento.

           select medicamentos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-medicamento.

       data division.
       file section.
       fd factura-venta
           label record is standard
           value of file-id "ventas.dat".
       01 reg-factura-venta.
          02 v-codigo-factura     pic x(6).
          02 v-numero-factura     pic x(6).
          02 v-rut-cliente        pic x(8).

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
          88 agregar-otro-registro value "1".
          88 volver-menu-principal value "2".
       77 numero-correlativo       pic 9(6)  value 0.
       77 linea-subrayado          pic x(80) value all "*".
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
              line 4 col 25 value is "ingreso de factura de venta".
           02 pantalla-fecha line 6 col 60
              foreground is white
              value is "fecha:".
              02 filler col 68
              pic is x(8) using fecha-programa. 
       01 pantalla-factura.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "numero de la factura:".
           02 filler col 40
              pic is z(5)9 using numero-correlativo.
           02 filler line 12 col 1
              foreground is white
              value is "ingrese rut del cliente:".
           02 filler line 14 col 1
              pic is x(80) using linea-subrayado.
       01 datos-factura.
           02 filler line 16 col 40
              pic is x(8) using v-rut-cliente required auto.
       01 pantalla-cliente.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "ingrese digito verificador:".
           02 filler line 12 col 1
              foreground is white
              value is "ingrese apellido:".
           02 filler line 14 col 1
              foreground is white
              value is "ingrese nombre:".
           02 filler line 16 col 1
              foreground is white
              value is "ingrese direccion:".
           02 filler line 18 col 1
              foreground is white
              value is "ingrese fono:".
           02 filler line 20 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
       01 datos-cliente.
           02 filler line 10 col 40
              pic is x using dv-cliente required auto.
           02 filler line 12 col 40
              pic is x(20) using apellido-cliente auto.
           02 filler line 14 col 40
              pic is x(20) using nombre-cliente auto.
           02 filler line 16 col 40
              pic is x(30) using dir-cliente auto.
           02 filler line 18 col 40
              pic is x(10) using fono-cliente auto.
       01 pantalla-movimiento.
           02 filler line 8 col 1
              foreground is white
              pic is x(80) using linea-subrayado.
           02 filler line 10 col 1
              foreground is white
              value is "ingrese codigo del medicamento:".
           02 filler line 12 col 1
              foreground is white
              value is "ingrese cantidad de movimiento:".
           02 filler line 14 col 1
              foreground is white
              value is "ingrese fecha de elavoracion (dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 16 col 1
              foreground is white
              value is "ingrese fecha de vencimiento(dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 18 col 1
              foreground is white
              value is "ingrese fecha de venta      (dd/mm/aa):".
           02 filler col 52 value is "/".
           02 filler col 55 value is "/".
           02 filler line 20 col 1
              foreground is white
              value is "ingrese descripcion".
           02 filler line 22 col 1
              foreground is white
              value is "ingrese precio costo unitario:".
           02 filler line 24 col 1
              foreground is white
              value is "ingrese unidad de medida:".
           02 filler line 26 col 1
              pic is x(80) using linea-subrayado.
        01 datos-pantalla-movimiento.
           02 filler line 10 col 50
              pic is x(6) using codigo-movimiento required auto.
           02 filler line 12 col 50
              pic is 9(5) using cantidad-movimiento required auto.
           02 filler line 14 col 50
              pic is 99 using v-dia-elavoracion required auto.
           02 filler col 53
              pic is 99 using v-mes-elavoracion required auto.
           02 filler col 56
              pic is 99 using v-ano-elavoracion required auto.
           02 filler line 16 col 50
              pic is 99 using v-dia-vencimiento required auto.
           02 filler col 53
              pic is 99 using v-mes-vencimiento required auto.
           02 filler col 56
              pic is 99 using v-ano-vencimiento required auto.
           02 filler line 18 col 50
              pic is 99 using dia-venta required auto.
           02 filler col 53
              pic is 99 using mes-venta required auto.
           02 filler col 56
              pic is 99 using ano-venta required auto.
           02 filler line 20 col 50
              pic is x(30) using descripcion-mov required auto.
           02 filler line 22 col 50
              pic is 9(7) using precio-costo-mov required auto.
           02 filler line 24 col 50
              pic is xx using unidad-med-mov auto.
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
           02 filelr line 18 col 25
              pic is x using opcion required auto.
       procedure division using fecha-sistema.
       incio.
       ajustar-fecha.
           move s-dia to dia.
           move s-mes to mes.
           move s-ano to ano.
       abrir-ficheros.
           open i-o factura-venta.
           open i-o clientes.
           open i-o movimiento-medicamento.
           open i-o medicamentos.
       desplejar-pantalla-principal.
           display pantalla-principal.
       fijar-codigo-factura-venta.
           read factura-venta next record at end go codigo-factura.
           add 1 to numero-correlativo.
           go fijar-codigo-factura-venta.
       codigo-factura.
           add 1 to numero-correlativo.
           close factura-venta.
           open i-o factura-venta.
       desplejar-pantalla-factura.
           display pantalla-factura.
           accept  datos-factura.
       grabar-registro-factura.
           move numero-correlativo to v-codigo-factura.
           move v-codigo-factura   to v-numero-factura.
           move 0 to numero-correlativo.
           write reg-factura-venta invalid key go mensaje-1.
      
       buscar-rut-cliente.
           read clientes next record
           at end go desplejar-pantalla-clientes.
           if v-rut-cliente = rut-cliente then
               go pantalla-medicamentos end-if
           go buscar-rut-cliente.
       desplejar-pantalla-clientes.
           display pantalla-principal.
           display pantalla-cliente.
           accept  datos-cliente.
       grabar-registro-clientes.
           move v-rut-cliente to rut-cliente.
           write reg-clientes invalid key go mensaje-2.
       pantalla-medicamentos.
           display pantalla-principal.
           display pantalla-movimiento.
           accept  datos-pantalla-movimiento.
      
       verificar-stock-medicamento.
           read medicamentos next record at end go mensaje-4.  
           if codigo-movimiento = codigo-medicamento then
              go grabar-registro-medicamento.
           go verificar-stock-medicamento.
       grabar-registro-medicamento.
           close medicamentos.
           open i-o medicamentos.
           move rut-cliente to rut-cliente-mov.
           write reg-movimiento invalid key go mensaje-3.
      *_si el usuario desea agregar otro medicamento a la factura
       desplejar-pantalla-pregunta.   
           display pantalla-principal.
           display pantalla-pregunta.
           accept  opcion-pantalla-pregunta.
           if opcion not numeric then go desplejar-pantalla-pregunta.
           if opcion < 1 or opcion > 2 then
              go desplejar-pantalla-pregunta.
           if opcion = 1 then go actualizar.
           if opcion = 2 then go actualizar-2.
       actualizar.
           read medicamentos next record at end go mensaje-4.
           if codigo-movimiento = codigo-medicamento then
              if cantidad-stock > cantidad-movimiento then
                 go regrabar-medicamento end-if
              if cantidad-stock = cantidad-movimiento then 
                 go eliminar-medicamento end-if
              if cantidad-stock < cantidad-movimiento then
                 go mensaje-5 end-if
           end-if.
           go actualizar. 
    
       eliminar-medicamento.
           move codigo-movimiento to codigo-medicamento.
           start medicamentos key equal codigo-medicamento.
           delete medicamentos.
       cerrar-actualizacion.
           close medicamentos.
           close movimiento-medicamento.
           open i-o medicamentos.
           close movimiento-medicamento.
           go desplejar-pantalla-pregunta.
     
       regrabar-medicamento.
           move codigo-movimiento to codigo-medicamento.
           start medicamentos key equal codigo-medicamento.
           compute cantidad-stock = cantidad-stock - cantidad-movimiento.
           rewrite reg-medicamentos.
       cerrar-regrabacion.
           close medicamentos.
           close movimiento-medicamento.
           open i-o medicamentos.
           close movimiento-medicamento.
           go desplejar-pantalla-pregunta.

     
       actualizar-2.
           read medicamentos next record at end go mensaje-4.
           if codigo-movimiento = codigo-medicamento then
              if cantidad-stock > cantidad-movimiento then
                 go regrabar-medicamento-2 end-if
              if cantidad-movimiento = cantidad-stock then 
                 go eliminar-medicamento-2 end-if
              if cantidad-stock < cantidad-movimiento then
                 go mensaje-5 end-if
           end-if.
           go actualizar-2. 
       
       eliminar-medicamento-2.
           move codigo-movimiento to codigo-medicamento.
           start medicamentos key equal codigo-medicamento.
           delete medicamentos.
           go volver.
       regrabar-medicamento-2.
           move codigo-movimiento to codigo-medicamento.
           start medicamentos key equal codigo-medicamento.
           compute cantidad-stock = cantidad-stock - cantidad-movimiento.
           rewrite reg-medicamentos.

       volver.
           close factura-venta.
           close clientes.
           close movimiento-medicamento.
           close medicamentos.
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
       mensaje-4.
           display " " line 1 col 1 erase.
           display "el medicamento no se encuentra en el stock"
                    line 4 col 1.
           go desplejar-pantalla-pregunta.
       mensaje-5.
           display " " line 1 col 1 erase.
           display "la cantidad de stock es menor al movimiento"
                    line 4 col 1.
           go pantalla-medicamentos. 
