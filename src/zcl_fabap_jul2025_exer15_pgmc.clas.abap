CLASS zcl_fabap_jul2025_exer15_pgmc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fabap_jul2025_exer15_pgmc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_dd_voo,
             carrierID    TYPE /dmo/carrier_id,
             connectionID TYPE /dmo/connection_id,
             price         TYPE /dmo/flight_price,
             distance      TYPE /dmo/flight_distance,
           END OF ty_dd_voo.

    DATA t_dd_voo TYPE SORTED TABLE OF ty_dd_voo
     WITH NON-UNIQUE KEY carrierID connectionID.

    SELECT f~carrier_id,
           f~connection_id,
           f~price,
           c~distance
      FROM /dmo/flight AS f
             INNER JOIN
               /dmo/connection AS c ON f~carrier_id = c~carrier_id
                                             AND f~connection_id = c~connection_id
      WHERE c~distance > 1000   AND
            f~carrier_id = 'UA' AND
            f~connection_id IN ( '0058', '0059', '1537' )
      INTO TABLE @t_dd_voo.

      LOOP AT t_dd_voo ASSIGNING FIELD-SYMBOL(<dd_voo>).
      <dd_voo>-price *= '1.10'.
      out->write( |Preço atualizado para voo { <dd_voo>-carrierID }-{ <dd_voo>-connectionID }| ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
