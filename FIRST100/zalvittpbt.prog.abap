*&---------------------------------------------------------------------*
*& Report ZALVITTPBT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALVITTPBT
    NO STANDARD PAGE HEADING MESSAGE-ID ZB11A_MSGCLASS.
* declarations
TYPES : BEGIN OF TYPE1,
         BUKRS LIKE LFB1-BUKRS,       "company code
         LIFNR LIKE LFB1-LIFNR,       "vendor no
         PERNR LIKE LFB1-PERNR,       "personnnel no
         AKONT LIKE LFB1-AKONT,       "account in general ledger
       END OF TYPE1.
* vendor company code internal table
DATA : IT_LFB1 TYPE TABLE OF TYPE1.

*  fieldcat
TYPE-POOLS : SLIS.
DATA : ITF TYPE SLIS_T_FIELDCAT_ALV,
       WAF TYPE SLIS_FIELDCAT_ALV.
*  Events for Top bottom headings
*  top bottom heading events
DATA : ITE TYPE SLIS_T_EVENT,
       WAE TYPE SLIS_ALV_EVENT.
* Variable process report id
DATA : VREPID LIKE SY-REPID.
*T001 is company code master
DATA : V1 LIKE T001-BUKRS.

*Input
   SELECTION-SCREEN BEGIN OF SCREEN 100 AS WINDOW.
        SELECT-OPTIONS : VBUKRS FOR V1 OBLIGATORY.
    SELECTION-SCREEN END OF SCREEN 100.
    CALL SELECTION-SCREEN 100 STARTING AT 20 1.

* Server side
  START-OF-SELECTION.
* report program name
    VREPID = SY-REPID.
* get vendor account numbers
    SELECT BUKRS LIFNR PERNR AKONT
           FROM LFB1
           INTO TABLE IT_LFB1
           WHERE BUKRS IN VBUKRS.
* Output process
  END-OF-SELECTION.
* IS INITIAL checks empty of internal table
    IF IT_LFB1 IS INITIAL.
       MESSAGE S002(2) WITH 'Company Vendors not found'.
    ELSE.
       PERFORM SUBR_SHOWALV_HEADING.
    ENDIF.

*&----------------------------------*
*&      Form  SUBR_SHOWALV_HEADING
*&-----------------------------------*
FORM SUBR_SHOWALV_HEADING .
* Asssign field cats
 WAF-COL_POS = 1.
 WAF-FIELDNAME = 'BUKRS'.
 WAF-KEY     = 'X'.
 WAF-JUST    = 'C'.
 WAF-seltext_m = 'Company code'.
 APPEND WAF TO ITF.
 CLEAR WAF.
 WAF-COL_POS = 2.
 WAF-FIELDNAME = 'LIFNR'.
 WAF-seltext_m = 'Vendor No'.
 APPEND WAF TO ITF.
 CLEAR WAF.

 WAF-COL_POS = 3.
 WAF-FIELDNAME = 'PERNR'.
 WAF-seltext_m = 'Personnel No'.
 APPEND WAF TO ITF.
 CLEAR WAF.

 WAF-COL_POS = 4.
 WAF-FIELDNAME = 'AKONT'.
 WAF-seltext_m = 'GL Account No'.
 APPEND WAF TO ITF.
 CLEAR WAF.

*assign top of page heading with event
* Top heading
WAE-NAME = 'TOP_OF_PAGE'.
WAE-FORM = 'SUBR_TOP'.   "subroutine name
APPEND WAE TO ITE.
CLEAR WAE.
* bottom heading
WAE-NAME = 'END_OF_LIST'.
WAE-FORM = 'SUBR_LIST'.  "subroutine name
APPEND WAE TO ITE.
CLEAR WAE.
* grid display
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
     I_CALLBACK_PROGRAM    = VREPID
     IT_FIELDCAT           = ITF
     IT_EVENTS             = ITE   "TOP BOTTOM events with Routines
   TABLES
    T_OUTTAB               = IT_LFB1.
ENDFORM.

* Events code for Top page and bottom headings
* subroutine for header
FORM SUBR_TOP.
DATA: RESULT TYPE STRING.
CONCATENATE 'DATE:'  SY-DATUM 'TIME:' SY-UZEIT INTO RESULT SEPARATED BY '-'.
* Data object for Top heading
  DATA : IT_LIST TYPE SLIS_T_LISTHEADER,
         WA_LIST TYPE SLIS_LISTHEADER.
       WA_LIST-TYP = 'H'.
       WA_LIST-INFO = 'TECHNOPAD VENDOR ACCOUNTS'.
       APPEND WA_LIST TO IT_LIST.
       CLEAR WA_LIST.

       WA_LIST-TYP = 'A'.
       WA_LIST-INFO = RESULT.
       APPEND WA_LIST TO IT_LIST.
       CLEAR WA_LIST.
* function module performs to write
*   top heading into GRID window
      CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
       EXPORTING
           IT_LIST_COMMENTARY       = IT_LIST
*         show back ground picture
           I_LOGO                   = 'ENJOY'.

 ENDFORM.

*Subroutine for footer
FORM SUBR_LIST.
* data object for bottom heading
 DATA : IT_LIST1 TYPE SLIS_T_LISTHEADER,
        WA_LIST1 TYPE SLIS_LISTHEADER.

       WA_LIST1-TYP = 'H'.
       WA_LIST1-INFO = 'THANK YOU..WELCOME AGAIN'.
       APPEND WA_LIST1 TO IT_LIST1.
       CLEAR WA_LIST1.
* function module performs to show
*  bottom heading into GRID window
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
   EXPORTING
      IT_LIST_COMMENTARY       = IT_LIST1
      I_LOGO                   = 'ENJOY'
      I_END_OF_LIST_GRID       = 'X'.
ENDFORM.
