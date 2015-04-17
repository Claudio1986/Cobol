       identification division.
       program-id. venta.
       author. claudio-ruz.
       environment division.
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
           value of file-id "movidos.dat".
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

       procedure division. 
       abrir-ficheros.
           open output factura-venta.
           open output clientes.
           open output movimiento-medicamento.
           close factura-venta.
           close clientes.
           close movimiento-medicamento.
           stop run. 
