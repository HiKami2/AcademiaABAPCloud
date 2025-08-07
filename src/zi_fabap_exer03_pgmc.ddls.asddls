@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercicio 03 para a Academia ABAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER03_PGMC
  as select from /dmo/customer
{
  key customer_id                                                              as CustomerID,
      first_name                                                               as FirstName,
      last_name                                                                as LastName,
      city                                                                     as City,
      street                                                                   as Street,
      country_code                                                             as Country_Code,

      concat( concat_with_space( concat(street, ','), city, 1 ), concat('-', country_code)) as Full_Address




}
