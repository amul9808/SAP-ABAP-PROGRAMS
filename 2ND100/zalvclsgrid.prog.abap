*&---------------------------------------------------------------------*
*& Report ZALVCLSGRID
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALVCLSGRID
NO STANDARD PAGE HEADING
MESSAGE-ID ZMSGCL.
*DECLARATIONS
DATA: ITVBAK TYPE TABLE OF VBAK.
*INPUTS
INCLUDE: ZINC4.
*PROCESS
START-OF-SELECTION.
PERFORM SUBR_OPENSQL.
END-OF-SELECTION.
*OUTPUT
CASE SY-SUBRC.
     WHEN 0.
       PERFORM SUBR_OUTPUT.
     WHEN 4.
       MESSAGE S001.
ENDCASE.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OPENSQL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_OPENSQL .
SELECT * INTO TABLE ITVBAK FROM VBAK WHERE ERDAT IN DATE AND KUNNR IN CUSTOMER.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUBR_OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SUBR_OUTPUT .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
  I_CALLBACK_PROGRAM                = SY-CPROG
  I_STRUCTURE_NAME                  = 'VBAK'
  I_GRID_TITLE                      = 'SALES HEADER DATA'
*
*   I_SCREEN_START_COLUMN             = 5
*   I_SCREEN_START_LINE               = 5
*   I_SCREEN_END_COLUMN               = 200
*   I_SCREEN_END_LINE                 = 15
  TABLES
    T_OUTTAB                          = ITVBAK.
ENDFORM.
