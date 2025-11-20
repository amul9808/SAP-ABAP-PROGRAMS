FUNCTION ZBAPI_FUNCMOD2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(BAPI_STRT) TYPE  LFA1-LIFNR
*"     VALUE(BAPI_END) TYPE  LFA1-LIFNR
*"  EXPORTING
*"     VALUE(RETURN) TYPE  BAPIRET2
*"  TABLES
*"      ITCUST STRUCTURE  ZBAPISTRUCT
*"  EXCEPTIONS
*"      NOTFOUND
*"----------------------------------------------------------------------
SELECT KUNNR LAND1 NAME1 ORT01 PSTLZ INTO TABLE ITCUST FROM LFA1 WHERE LIFNR BETWEEN BAPI_STRT AND BAPI_END.
  IF SY-SUBRC NE 0.
    RAISE NOTFOUND.
  ENDIF.



ENDFUNCTION.
