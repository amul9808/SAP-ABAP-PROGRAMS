FUNCTION RFMPODATA.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(RFM_LIFNR) TYPE  EKKO-LIFNR
*"  TABLES
*"      RFM_ITEKKO STRUCTURE  EKKO
*"  EXCEPTIONS
*"      NOTFOUND
*"----------------------------------------------------------------------
 SELECT *
   INTO TABLE RFM_ITEKKO FROM EKKO
   WHERE LIFNR EQ RFM_LIFNR.
 IF SY-SUBRC NE 0.
   RAISE NOTFOUND.
 ENDIF.
ENDFUNCTION.
