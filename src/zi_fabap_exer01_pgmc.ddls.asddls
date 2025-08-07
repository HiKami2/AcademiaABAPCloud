@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercicio 01 para a Academia ABAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER01_PGMC as select from /dmo/flight  as Flight
    inner join   /dmo/carrier as Carrier on Carrier.carrier_id = Flight.carrier_id
{
  key Flight.carrier_id         as CarrierId,
  key Flight.connection_id      as ConnectionId,
  key Flight.flight_date        as FlightDate,
      Carrier.name              as CarrierName,
      Flight.seats_max          as SeatsMax,
      Flight.seats_occupied     as SeatsOccupied,
      concat( cast (
               cast( ( Flight.seats_occupied / Flight.seats_max ) * 100 as abap.dec( 8, 2 )
                                                            ) as abap.char( 20 ) ), '%' ) as OccupancyRate
}
