@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DDL EXAMPLE-SFLIGHT TABLE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPK_DDL_HW2 as select from sflight
{
    key carrid as airline_code,
    connid as flight_connection_number,
    fldate as flight_date,
    currency as local_currency_of_airline,
    planetype as aircraft_type,
    seatsmax as maximum_capasity_in_ec,
    seatsocc as occupied_seats_in_ec,
    seatsmax_b as maximum_capasity_in_bc,
    seatsocc_b as occupied_seats_in_bc,
    seatsmax_f as maximum_capasity_in_fc,
    seatsocc_f as occupied_seats_in_fc
    
}
