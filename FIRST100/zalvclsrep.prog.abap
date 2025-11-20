*&---------------------------------------------------------------------*
*& Report ZALVCLSREP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALVCLSREP
NO STANDARD PAGE HEADING
MESSAGE-ID ZMSGCL.
*DECLARATION
DATA ITKNA1 TYPE TABLE OF KNA1.
*INPUT
INCLUDE : ZINC3.
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
*&      Form  SUBR_OPENSQL
FORM SUBR_OPENSQL .
     SELECT NAME1 STRAS ORT01 PSTLZ LAND1 TELF1
       INTO TABLE ITKNA1 FROM KNA1
       WHERE KUNNR IN CUSTOMER.
ENDFORM.
*&      Form  SUBR_OUTPUT
FORM SUBR_OUTPUT .
CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM             = SY-CPROG
   I_STRUCTURE_NAME               = 'KNA1'
  TABLES
    T_OUTTAB                       = ITKNA1.

ENDFORM.
