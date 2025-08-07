CLASS zcl_fabap_jul2025_exer17_pgmc DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_fabap_jul2025_exer17_pgmc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_t_flight,
             carrier_id    TYPE /dmo/flight-carrier_id,
             connection_id TYPE /dmo/flight-connection_id,
           END OF ty_t_flight.

    TYPES: BEGIN OF ty_t_booking,
             carrier_id    TYPE /dmo/booking-carrier_id,
             connection_id TYPE /dmo/booking-connection_id,
             flight_date   TYPE /dmo/booking-flight_date,
           END OF ty_t_booking.

    DATA t_flights  TYPE SORTED TABLE OF ty_t_flight
                        WITH NON-UNIQUE KEY carrier_id connection_id.

    DATA t_bookings TYPE SORTED TABLE OF ty_t_booking
                        WITH NON-UNIQUE KEY carrier_id connection_id.

    SELECT carrier_id,
           connection_id
      FROM /dmo/flight
      INTO TABLE @t_flights.

    IF sy-subrc = 0.

      SELECT carrier_id, connection_id, flight_date
        FROM /dmo/booking
        FOR ALL ENTRIES IN @t_flights
        WHERE carrier_id    = @t_flights-carrier_id
          AND connection_id = @t_flights-connection_id
        INTO TABLE @t_bookings.
    ENDIF.

    LOOP AT t_flights INTO DATA(flight).
      READ TABLE t_bookings WITH KEY carrier_id    = flight-carrier_id
                                     connection_id = flight-connection_id

           TRANSPORTING NO FIELDS
           BINARY SEARCH.

      IF sy-subrc = 0.

        DATA(v_tabix) = sy-tabix.
        LOOP AT t_bookings FROM v_tabix INTO DATA(booking).
          IF    booking-carrier_id    <> flight-carrier_id
             OR booking-connection_id <> flight-connection_id.
            EXIT.
          ENDIF.
          out->write( |Voo { booking-carrier_id } { booking-connection_id }: { booking-flight_date }| ).
        ENDLOOP.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
