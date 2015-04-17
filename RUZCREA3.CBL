       identification division.
       program-id. crea-vencidos.
       author. claudio-ruz.
       environment division.
       configuration section.
       special-names.
           decimal-point is comma.
       input-output section.
       file-control.

           select prod-vencidos assign to disk
           organization is indexed
           access mode is dynamic
           record key is codigo-vencido.

       data division.
       file section.
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

       procedure division. 
       abrir-fichero.
           open output prod-vencidos.
           close prod-vencidos.
           stop run. 
