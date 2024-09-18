@AbapCatalog.sqlViewName: 'ZCFLIGHTBKINGPK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Booking Consumption View for Fiori Application'
@vdm.viewType: #CONSUMPTION
define view ZC_FLIGHTBOOKING_PK as select from ZI_FLIGHTBOOKING_PK
association [1..1] to ZC_FLIGHTS_PK as _flights_hdr
 on $projection.Airline = _flights_hdr.Airline and 
 $projection.FlightNumber = _flights_hdr.FlightNumber and 
 $projection.FlightDate = _flights_hdr.FlightDate
{
    key Airline,
    key FlightNumber,
    key FlightDate,
    key FlightBooking,
    FlightCustomer,
    CustomerName,
    CustomerCity
    /* Associations */
//    _flights,
//    _flight_customer,
// _flights_hdr // Make association public
}
