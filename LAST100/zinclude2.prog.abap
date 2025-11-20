*&---------------------------------------------------------------------*
*&  Include           ZINCLUDE2
*&---------------------------------------------------------------------*
FORM SUBR USING P_PHASE CHANGING P_UNITRATE.
     IF P_PHASE EQ 1.
       P_UNITRATE = 5.
     ELSEIF P_PHASE EQ 3.
       P_UNITRATE = 8.
     ELSE.
       WRITE:/5 'INVALID PHASE NO.' COLOR 4.
     ENDIF.
ENDFORM.
FORM SUBR1 USING P_CURRREAD P_PREVREAD CHANGING P_UNITUSED.
      P_UNITUSED = P_CURRREAD - P_PREVREAD.
ENDFORM.
FORM SUBR2 USING P_UNITRATE P_UNITUSED CHANGING P_BILLAMT.
      P_BILLAMT = P_UNITRATE * P_UNITUSED.
ENDFORM.
