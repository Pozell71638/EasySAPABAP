@AbapCatalog.sqlViewName: 'ZCFLIGHTSPK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for Fiori Application'
@VDM.viewType: #CONSUMPTION
define view ZC_FLIGHTS_PK
  as select from ZI_Flights
  association [0..*] to ZC_FLIGHTBOOKING_PK as _flight_booking_itm on  $projection.Airline      = _flight_booking_itm.Airline
                                                                   and $projection.FlightNumber = _flight_booking_itm.FlightNumber
                                                                   and $projection.FlightDate   = _flight_booking_itm.FlightDate
{
  key Airline,
  key FlightNumber,
  key FlightDate,
      PlaneType,
      CityFrom,
      CityTo
      /* Associations */
//     _flight_booking,
//      _flight_schedule,
//      _flight_booking_itm // Make association public
}
