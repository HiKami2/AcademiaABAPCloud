CLASS zcl_fabap_jul2025_exer13_pgmc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fabap_jul2025_exer13_pgmc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(v_carrierID) = 'AA'.
    out->write( |New Version - Carrier ID: { v_carrierID }| ).

    TYPES: BEGIN OF ty_flight,
             carrierID    TYPE /dmo/carrier_id,
             connectionID TYPE /dmo/connection_id,
             flightDate   TYPE /dmo/flight_date,
           END OF ty_flight.
    DATA: t_flights TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY.
    t_flights = VALUE #( ( carrierID = 'LH' connectionID = '0400' flightDate = '20250725' ) ).
    LOOP AT t_flights INTO DATA(s_flight).
      out->write( |New Version - Flight: { s_flight-carrierID }-{ s_flight-connectionID }| ).
    ENDLOOP.

    SELECT * FROM /dmo/flight INTO TABLE @DATA(t_flights_select) UP TO 2 ROWS.
    out->write( |New Version - Flights found (SELECT): { lines( t_flights_select ) }| ).

    TRY.
        DATA(s_flight_expr) = t_flights[ 1 ].
        out->write( |New Version - First Flight: { s_flight_expr-carrierID }-{ s_flight_expr-connectionID }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - No first flight found.| ).
    ENDTRY.

    TRY.
        DATA(s_flight_key) = t_flights[ carrierID = 'LH' connectionID = '0400' ].
        out->write( |New Version - Flight LH-0400: { s_flight_key-carrierID }-{ s_flight_key-connectionID }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - Flight LH-0400 not found.| ).
    ENDTRY.

    DATA(v_char) = '12345'.
    DATA(v_int) = CONV i( v_char ).
    out->write( |New Version - Converted to INT: { v_int }| ).

    TYPES t_flight_tt TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY.

    DATA(s_connection) = VALUE /dmo/connection(
      airport_from_id = 'FRA'
      airport_to_id   = 'JFK'
    ).

    out->write( |New Version - Connection: { s_connection-airport_from_id }-{ s_connection-airport_to_id }| ).

    DATA(t_flights_value) = VALUE t_flight_tt(
      ( carrierID = 'UA' connectionID = '0001' flightDate = '20250725' )
      ( carrierID = 'DL' connectionID = '0002' flightDate = '20250726' )
    ).

    out->write( |New Version - Flights count (VALUE): { lines( t_flights_value ) }| ).

    DATA(t_flights_for) =
     VALUE t_flight_tt( FOR s_flight2 IN t_flights_value WHERE ( carrierID = 'UA' )
                         ( carrierID = s_flight2-carrierID connectionID = s_flight2-connectionID ) ).

    out->write( |New Version - Flights for UA (FOR): { lines( t_flights_for ) }| ).

    TYPES t_number TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(t_numbers) = VALUE t_number( ( 1 ) ( 2 ) ( 3 ) ).

    DATA(v_sum) = REDUCE i( INIT s = 0 FOR n IN t_numbers NEXT s = s + n ).

    out->write( |New Version - Sum: { v_sum }| ).

    DATA(v_code_cond) = 1.
    DATA(v_status_cond) = COND string(
      WHEN v_code_cond = 1 THEN 'Success'
      WHEN v_code_cond = 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |New Version - Status (COND): { v_status_cond }| ).

    DATA(v_code_switch) = 2.
    DATA(v_status_switch) = SWITCH string( v_code_switch
      WHEN 1 THEN 'Success'
      WHEN 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |New Version - Status (SWITCH): { v_status_switch }| ).

    TYPES: BEGIN OF ty_s1,
             field1 TYPE string,
             field2 TYPE string,
           END OF ty_s1.

    TYPES: BEGIN OF ty_s2,
             field1 TYPE string,
             field3 TYPE string,
           END OF ty_s2.

    DATA: s_s1 TYPE ty_s1.

    s_s1-field1 = 'Value1'.
    s_s1-field2 = 'Value2'.

    DATA(s_s2) = CORRESPONDING ty_s2( s_s1 ).

    out->write( |New Version - S2 Field1 (CORRESPONDING): { s_s2-field1 }| ).

    DATA(v_var1_str) = 'Hello'.
    DATA(v_var2_str) = 'World'.
    DATA(v_result_str) = v_var1_str && ' ' && v_var2_str.
    out->write( |New Version - Chaining Operator (Strings): { v_result_str }| ).

    DATA(v_name_str) = 'ABAP'.
    DATA(v_version_str) = '7.40'.
    DATA(v_template_string) = |Welcome to { v_name_str } { v_version_str }!|.
    out->write( |New Version - String Template (Strings): { v_template_string }| ).

    DATA(v_delivery_number) = '0080003371'.
    DATA(v_formatted_delivery) = |{ v_delivery_number ALPHA = OUT }|.
    out->write( |New Version - Embedded Expression (ALPHA) (Strings): { v_formatted_delivery }| ).

    TYPES: BEGIN OF ty_flight_group,
             carrierID    TYPE /dmo/carrier_id,
             connectionID TYPE /dmo/connection_id,
             price         TYPE /dmo/flight_price,
           END OF ty_flight_group.

    DATA: t_flights_group TYPE STANDARD TABLE OF ty_flight_group WITH EMPTY KEY.

    t_flights_group = VALUE #( ( carrierID = 'LH' connectionID = '0400' price = '100' )
                               ( carrierID = 'LH' connectionID = '0401' price = '150' )
                               ( carrierID = 'UA' connectionID = '0001' price = '200' ) ).

    LOOP AT t_flights_group INTO DATA(s_flight_group) GROUP BY s_flight_group-carrierID.
      DATA(v_total_price_group) = REDUCE /dmo/flight_price( INIT s = 0 FOR member IN GROUP s_flight_group NEXT s = s + member-price ).
      out->write( |New Version - Carrier { s_flight_group-carrierID } Total Price (Group By): { v_total_price_group }| ).
    ENDLOOP.

    DATA t_flights_sorted TYPE SORTED TABLE OF ty_flight WITH UNIQUE KEY carrierID connectionID.

    DATA(t_flights_filtered) = FILTER #( t_flights_sorted WHERE carrierID = CONV #( 'AA' ) ).

    out->write( |New Version - Filtered flights (LH): { lines( t_flights_filtered ) }| ).

  ENDMETHOD.
ENDCLASS.
