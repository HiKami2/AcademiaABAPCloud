@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercicio 02 para a Academia ABAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER02_PGMC
  as select from /dmo/connection as connection
    inner join   /dmo/carrier    as carrier on carrier.carrier_id = connection.carrier_id
{
  key connection.carrier_id                     as CarrierId,
      carrier.name                              as Name,
      count( distinct connection.connection_id) as Total_Conexoes,
      max(connection.distance)                  as Distancia_Maxima

}
group by
  connection.carrier_id,
  carrier.name
