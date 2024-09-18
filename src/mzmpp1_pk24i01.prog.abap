*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK24I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2031  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2031 INPUT.

  CASE sy-ucomm.
    WHEN 'LOG1'.
      SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
        FROM zpk_employer_t
        INTO wa   WHERE  EMPLOYER_id = zpk_employer_t-EMPLOYER_id AND
              EMPLOYER_password = zpk_employer_t-EMPLOYER_password.
      IF sy-subrc = 0.
        MESSAGE 'Login Successful' TYPE 'I'.
        CALL SCREEN 2032.

      ELSE.
        MESSAGE ' Please check your details' TYPE 'I'.
      ENDIF.



    WHEN'CLEAR1'.
      CLEAR:zpk_employer_t-EMPLOYER_id, zpk_employer_t-employer_name, zpk_employer_t-EMPLOYER_password.
    WHEN 'EXIT1'.
      LEAVE PROGRAM.
    WHEN 'SAVE1'.
      PERFORM save.
    WHEN 'CHANGE1'.
      PERFORM change.
*
*
*
*      WHEN 'EXIT1'.
*        LEAVE PROGRAM.
*      WHEN 'LOG1'.
*        CALL TRANSACTION 'ZSHP15'.
  ENDCASE.





ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2032  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2032 INPUT.

  CASE sy-ucomm.

    WHEN 'DISP2'.
      SELECT SINGLE passenger_id name passport_number date_of_birth  gender email landline mobile building  city country pin_code
         FROM zpk_lpassenger_t
        INTO (zpk_lpassenger_t-passenger_id, zpk_lpassenger_t-name, zpk_lpassenger_t-passport_number, zpk_lpassenger_t-date_of_birth,
 zpk_lpassenger_t-gender,zpk_lpassenger_t-email, zpk_lpassenger_t-landline,zpk_lpassenger_t-mobile, zpk_lpassenger_t-building, zpk_lpassenger_t-city, zpk_lpassenger_t-country,zpk_lpassenger_t-pin_code)
      WHERE  passenger_id = zpk_lpassenger_t-passenger_id.
   WHEN 'AIRLINES'.
        CALL SCREEN 2033.

    SELECT SINGLE passenger_id  airline_code airline_name flight_number origin destination departure_times arrival_times aircraft_type seating_capacity departure_date arrival_date
         FROM zpk_airlines_t
        INTO (zpk_airlines_t-passenger_id, zpk_airlines_t-airline_code, zpk_airlines_t-airline_name, zpk_airlines_t-flight_number,
zpk_airlines_t-origin,zpk_airlines_t-destination, zpk_airlines_t-departure_times,zpk_airlines_t-arrival_times, zpk_airlines_t-aircraft_type, zpk_airlines_t-seating_capacity, zpk_airlines_t-departure_date,zpk_airlines_t-arrival_date)
      WHERE  passenger_id = zpk_lpassenger_t-passenger_id.



    WHEN'CLEAR2'.
      CLEAR:zpk_lpassenger_t-passenger_id, zpk_lpassenger_t-name, zpk_lpassenger_t-passport_number, zpk_lpassenger_t-date_of_birth,
 zpk_lpassenger_t-gender,zpk_lpassenger_t-email, zpk_lpassenger_t-landline,zpk_lpassenger_t-mobile, zpk_lpassenger_t-building, zpk_lpassenger_t-city, zpk_lpassenger_t-country,zpk_lpassenger_t-pin_code.
    WHEN 'EXIT2'.
      LEAVE PROGRAM.
    WHEN 'SAVE2'.
      PERFORM save2.
    WHEN 'CHANGE2'.
      PERFORM change2.
    WHEN 'BACK2'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.







*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2033  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2033 INPUT.



  CASE sy-ucomm.

    WHEN 'DISP3'.
      SELECT SINGLE passenger_id  airline_code airline_name flight_number origin destination departure_times arrival_times aircraft_type seating_capacity departure_date arrival_date
         FROM zpk_airlines_t
        INTO (zpk_airlines_t-passenger_id, zpk_airlines_t-airline_code, zpk_airlines_t-airline_name, zpk_airlines_t-flight_number,
zpk_airlines_t-origin,zpk_airlines_t-destination, zpk_airlines_t-departure_times,zpk_airlines_t-arrival_times, zpk_airlines_t-aircraft_type, zpk_airlines_t-seating_capacity, zpk_airlines_t-departure_date,zpk_airlines_t-arrival_date)
      WHERE  passenger_id = zpk_airlines_t-passenger_id.
    WHEN'CLEAR3'.
      CLEAR:zpk_airlines_t-passenger_id, zpk_airlines_t-airline_code, zpk_airlines_t-airline_name, zpk_airlines_t-flight_number,
zpk_airlines_t-origin,zpk_airlines_t-destination, zpk_airlines_t-departure_times,zpk_airlines_t-arrival_times, zpk_airlines_t-aircraft_type, zpk_airlines_t-seating_capacity, zpk_airlines_t-departure_date,zpk_airlines_t-arrival_date.
    WHEN 'EXIT3'.
      LEAVE PROGRAM.
    WHEN 'SAVE3'.
      PERFORM save3.
    WHEN 'CHANGE3'.
      PERFORM change3.
    WHEN 'BACK3'.
      LEAVE TO SCREEN 0.
  ENDCASE.



ENDMODULE.
