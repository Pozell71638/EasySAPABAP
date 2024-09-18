@AbapCatalog.sqlViewName: 'ZIFLIGHTBKING_PK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FLIGHT BOOKING'
@VDM.viewType: #COMPOSITE
define view ZI_FLIGHTBOOKING_PK
  as select from ZI_SBOOK
  association [1..1] to ZI_SCUSTOM as _flight_customer on  $projection.FlightCustomer = _flight_customer.FlightCustomer

  association [1..1] to ZI_Flights as _flights // one booking to the obe flight
                                                       on  $projection.Airline      = _flights.Airline
                                                       and $projection.FlightNumber = _flights.FlightNumber
                                                       and $projection.FlightDate   = _flights.FlightDate

{
  key Airline,
  key FlightNumber,
  key FlightDate,
  key FlightBooking,
      FlightCustomer,
      _flight_customer.CustomerName,
      _flight_customer.CustomerCity,
      _flight_customer,
      _flights // Make association public
}
