*&---------------------------------------------------------------------*
*& Report ZBAPIALVREP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBAPIALVREP
NO STANDARD PAGE HEADING
MESSAGE-ID ZMSGCL.
*DECLARATIONS
DATA: ITCST TYPE TABLE OF ZBAPISTRUCT.
DATA: V1 TYPE LFA1-LIFNR.
DATA: BAPIRET TYPE BAPIRET2.

DATA:IT_FLDCAT TYPE SLIS_T_FIELDCAT_ALV,
     WA_FLDCAT TYPE SLIS_FIELDCAT_ALV.
*INPUT
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
  SELECT-OPTIONS VENDOR FOR V1.
SELECTION-SCREEN END OF BLOCK B1.
INITIALIZATION.
T1 = 'SELECT CUSTOMER'.
*PROCES
START-OF-SELECTION.
CALL FUNCTION 'ZBAPI_FUNCMOD2'
  EXPORTING
    BAPI_STRT       = VENDOR-LOW
    BAPI_END        = VENDOR-HIGH
 IMPORTING
  RETURN          = BAPIRET
  TABLES
    ITCUST          = ITCST.

END-OF-SELECTION.
*OUTPUT
CASE SY-SUBRC.
  WHEN 0.
    PERFORM SUBR_FCAT.
    PERFORM SUBR_OUTPUT.
  WHEN 4.
    MESSAGE S001.
ENDCASE.
*&------------------------------*
*&      Form  SUBR_OUTPUT
*&------------------------------*
FORM SUBR_OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING

 I_GRID_TITLE                      = 'CUSTOMER DATA'
 IT_FIELDCAT                       = IT_FLDCAT
  TABLES
    T_OUTTAB                          = ITCST.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_FCAT .
 WA_FLDCAT-FIELDNAME = 'KUNNR'.
WA_FLDCAT-REF_TABNAME = 'LFA1'.
WA_FLDCAT-REF_FIELDNAME = 'KUNNR'.
APPEND WA_FLDCAT TO IT_FLDCAT.

WA_FLDCAT-FIELDNAME = 'LAND1'.
WA_FLDCAT-REF_TABNAME = 'LFA1'.
WA_FLDCAT-REF_FIELDNAME = 'LAND1'.
APPEND WA_FLDCAT TO IT_FLDCAT.

 WA_FLDCAT-FIELDNAME = 'NAME1'.
WA_FLDCAT-REF_TABNAME = 'LFA1'.
WA_FLDCAT-REF_FIELDNAME = 'NAME1'.
APPEND WA_FLDCAT TO IT_FLDCAT.

 WA_FLDCAT-FIELDNAME = 'ORT01'.
WA_FLDCAT-REF_TABNAME = 'LFA1'.
WA_FLDCAT-REF_FIELDNAME = 'ORT01'.
APPEND WA_FLDCAT TO IT_FLDCAT.

 WA_FLDCAT-FIELDNAME = 'PSTLZ'.
WA_FLDCAT-REF_TABNAME = 'LFA1'.
WA_FLDCAT-REF_FIELDNAME = 'PSTLZ'.
APPEND WA_FLDCAT TO IT_FLDCAT.


ENDFORM.
