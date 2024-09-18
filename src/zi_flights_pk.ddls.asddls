@AbapCatalog.sqlViewName: 'ZIFLIGTS_PK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Data'
@VDM.viewType: #COMPOSITE
define view ZI_FLIGHTS_PK
  as select from ZI_SFLIGHT
  association [1..1] to ZI_SPFLI         as _flight_schedule on  $projection.Airline      = _flight_schedule.Airline
                                                             and $projection.FlightNumber = _flight_schedule.FlightNumber

  association [0..*] to ZI_FlightBooking as _flight_booking //one flight multiple booking
                                                             on  $projection.Airline      = _flight_booking.Airline
                                                             and $projection.FlightNumber = _flight_booking.FlightNumber
                                                             and $projection.FlightDate   = _flight_booking.FlightDate
{
  key Airline,
  key FlightNumber,
  key FlightDate,
      PlaneType,
      _flight_schedule.CityFrom, //Ad-Hoc assocciation
      _flight_schedule.CityTo,   //Ad-Hoc assocciation
      _flight_schedule, // Exposed association
      _flight_booking // Exposed association

}
