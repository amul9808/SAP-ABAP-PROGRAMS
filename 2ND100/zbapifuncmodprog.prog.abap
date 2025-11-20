*&---------------------------------------------------------------------*
*& Report ZBAPIFUNCMODPROG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBAPIFUNCMODPROG.
*executable program selected Vendor po items
   PARAMETERS : COMPANY LIKE BAPI3008_1-COMP_CODE,
                          VENDOR  LIKE BAPI3008_1-VENDOR,
                          PODATE  LIKE BAPI3008-KEY_DATE.

   DATA : IT_OITEMS LIKE TABLE OF BAPI3008_2,
              WA_OITEMS LIKE LINE OF IT_OITEMS.

   DATA : WA_RETURN LIKE BAPIRETURN.

   CALL FUNCTION 'BAPI_AP_ACC_GETOPENITEMS'
     EXPORTING
       COMPANYCODE       = COMPANY
       VENDOR                  = VENDOR
       KEYDATE                 = PODATE
    IMPORTING
      RETURN            = WA_RETURN
     TABLES
       LINEITEMS        = IT_OITEMS.

     IF NOT WA_RETURN IS INITIAL.
        WRITE :/ WA_RETURN.

     ELSE.
        LOOP AT IT_OITEMS INTO WA_OITEMS.
           WRITE :/ WA_OITEMS-COMP_CODE,WA_OITEMS-VENDOR,
                         WA_OITEMS-DOC_NO.
        ENDLOOP.
 ENDIF.
