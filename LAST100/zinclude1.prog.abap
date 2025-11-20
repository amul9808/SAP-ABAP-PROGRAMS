*&---------------------------------------------------------------------*
*&  Include           ZINCLUDE1
*&---------------------------------------------------------------------*
FORM SUBR USING P_JOBCODE CHANGING P_BASIC.
     CASE P_JOBCODE.
       WHEN 'PMGR'.
         P_BASIC = 99000.
       WHEN 'AMGR'.
         P_BASIC = 75000.
       WHEN 'FCON'.
         P_BASIC = 66000.
       WHEN 'ACON'.
         P_BASIC = 99000.
       ENDCASE.
ENDFORM.
