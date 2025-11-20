*****           Implementation of object type ZBUS2                *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
      KEY LIKE SWOTOBJID-OBJKEY.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD CUSTOMERDATA CHANGING CONTAINER.
DATA:
      BAPISTRT TYPE LFA1-LIFNR,
      BAPIEND TYPE LFA1-LIFNR,
      RETURN LIKE BAPIRET2,
      ITCUST LIKE ZBAPISTRUCT OCCURS 0.
  SWC_GET_ELEMENT CONTAINER 'BapiStrt' BAPISTRT.
  SWC_GET_ELEMENT CONTAINER 'BapiEnd' BAPIEND.
  SWC_GET_TABLE CONTAINER 'Itcust' ITCUST.
  CALL FUNCTION 'ZBAPI_FUNCMOD2'
    EXPORTING
      BAPI_STRT = BAPISTRT
      BAPI_END = BAPIEND
    IMPORTING
      RETURN = RETURN
    TABLES
      ITCUST = ITCUST
    EXCEPTIONS
      NOTFOUND = 9001
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
    WHEN 9001.         " NOTFOUND
      EXIT_RETURN 9001 sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    WHEN OTHERS.       " to be implemented
  ENDCASE.
  SWC_SET_ELEMENT CONTAINER 'Return' RETURN.
  SWC_SET_TABLE CONTAINER 'Itcust' ITCUST.
END_METHOD.
