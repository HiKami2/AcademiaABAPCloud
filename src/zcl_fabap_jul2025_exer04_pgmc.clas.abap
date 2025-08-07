CLASS ZCL_FABAP_JUL2025_EXER04_PGMC DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES gty_conn TYPE STANDARD TABLE OF zi_fabap_demo01_eat WITH EMPTY KEY.

    CLASS-METHODS get_data AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      EXPORTING VALUE(et_data) TYPE gty_conn.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER04_PGMC IMPLEMENTATION.


  METHOD get_data BY DATABASE PROCEDURE
   FOR HDB LANGUAGE SQLSCRIPT
   OPTIONS READ-ONLY
   USING zi_fabap_demo01_eat.

    et_data = select Connection.carrierid     as CarrierId,
                     UPPER(Connection.carriername)   as CarrierName,
                     Connection.connectionid  as ConnectionId,
                     Connection.airportfromid as AirportFromId,
                     Connection.airporttoid   as AirportToId,

                     case when  Connection.airportfromid = 'SFO'
                      then '080000'
                      else Connection.departuretime
                      end as DepartureTime,

                     Connection.arrivaltime   as ArrivalTime,


                     Connection.distance      as Distance,
                     Connection.distanceunit  as DistanceUnit
     from ZI_FABAP_DEMO01_EAT   as Connection;
  ENDMETHOD.
ENDCLASS.
