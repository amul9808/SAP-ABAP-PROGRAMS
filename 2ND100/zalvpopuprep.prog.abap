*&---------------------------------------------------------------------*
*& Report ZALVPOPUPREP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALVPOPUPREP
NO STANDARD PAGE HEADING
MESSAGE-ID ZMSGCL.
*DECLARATION
DATA: ITAB TYPE STANDARD TABLE OF ZSTR1.
DATA: BEGIN OF PITAB OCCURS 1,
         EBELN TYPE EKPO-EBELN,
         AEDAT TYPE EKPO-AEDAT,
         LGORT TYPE EKPO-LGORT,
      END OF PITAB.
  TYPE-POOLS:SLIS.
*FILEDCATALOG
DATA:IT_FLDCAT TYPE SLIS_T_FIELDCAT_ALV,
     WA_FLDCAT TYPE SLIS_FIELDCAT_ALV.
*EVENTS
DATA: ITE TYPE SLIS_T_EVENT,
      WAE TYPE SLIS_ALV_EVENT.
*INPUT
INCLUDE: ZINC6.
*PROCESS
START-OF-SELECTION.
  PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
*OUTPUT
CASE SY-SUBRC.
  WHEN 0.
    PERFORM SUBR_OUTPUT1.
  WHEN 4.
    MESSAGE S004.
ENDCASE.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL
*&---------------------------------------------------------------------*
FORM SUBR_OPENSQL .
     SELECT EBELN BUKRS BSART LIFNR BEDAT
       INTO TABLE ITAB FROM EKKO
       WHERE LIFNR EQ VENDOR
       AND BEDAT IN PODATE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT1
*&---------------------------------------------------------------------*
FORM SUBR_OUTPUT1 .
  WAE-NAME = 'USER_COMMAND'.
  WAE-FORM = 'SUBR_EVENT'.
  APPEND WAE TO ITE.
  CLEAR WAE.
*CALL FUNCTION FOR GRID DISPLAY
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-CPROG
   I_STRUCTURE_NAME                  = 'ZSTR1'
   I_GRID_TITLE                      = 'PURCHASE ORDER HEADER DATA'
   IT_EVENTS                         =  ITE
  TABLES
    T_OUTTAB                         = ITAB.
ENDFORM.
*-----------------------------*
*INTERACTIVE POP UP WINDOW
*-----------------------------*
FORM SUBR_EVENT USING PV1 TYPE SY-UCOMM PV2 TYPE SLIS_SELFIELD.
  DATA: VPONO(10) TYPE N.
   IF PV2-FIELDNAME EQ 'EBELN'.
     VPONO = PV2-VALUE.
      SELECT EBELN AEDAT LGORT
        INTO TABLE PITAB FROM EKPO
        WHERE EBELN EQ VPONO.
            IF SY-SUBRC EQ 0.
              PERFORM SUBR_FCAT.
              PERFORM SUBR_OUTPUT2.
            ELSE.
              MESSAGE S004.
            ENDIF.
    ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_FCAT
*&---------------------------------------------------------------------*
FORM SUBR_FCAT .
 WA_FLDCAT-FIELDNAME = 'EBELN'.
WA_FLDCAT-REF_TABNAME = 'EKPO'.
WA_FLDCAT-REF_FIELDNAME = 'EBELN'.
APPEND WA_FLDCAT TO IT_FLDCAT.

WA_FLDCAT-FIELDNAME = 'AEDAT'.
WA_FLDCAT-REF_TABNAME = 'EKPO'.
WA_FLDCAT-REF_FIELDNAME = 'AEDAT'.
APPEND WA_FLDCAT TO IT_FLDCAT.

WA_FLDCAT-FIELDNAME = 'LGORT'.
WA_FLDCAT-REF_TABNAME = 'EKPO'.
WA_FLDCAT-REF_FIELDNAME = 'LGORT'.
APPEND WA_FLDCAT TO IT_FLDCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT2
*&---------------------------------------------------------------------*
FORM SUBR_OUTPUT2 .
CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
  EXPORTING
   I_TITLE                       = 'PO ITEMS INFO.'
   I_SCREEN_START_COLUMN         = 10
   I_SCREEN_START_LINE           = 10
   I_SCREEN_END_COLUMN           = 60
   I_SCREEN_END_LINE             = 16
    I_TABNAME                    = 'EKPO'
   IT_FIELDCAT                   = IT_FLDCAT
   I_CALLBACK_PROGRAM            = SY-CPROG
  TABLES
    T_OUTTAB                     =  PITAB.
ENDFORM.
