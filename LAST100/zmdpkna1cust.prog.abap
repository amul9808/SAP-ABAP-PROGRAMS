*&---------------------------------------------------------------------*
*& Module Pool       ZMDPKNA1CUST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM ZMDPKNA1CUST.
TABLES:KNA1.
DATA: BEGIN OF ITAB,
        KUNNR TYPE KNA1-KUNNR,
        NAME1 TYPE KNA1-NAME1,
        LAND1 TYPE KNA1-LAND1,
        ORT01 TYPE KNA1-ORT01,
        REGIO TYPE KNA1-REGIO,
        STRAS TYPE KNA1-STRAS,
        TELF1 TYPE KNA1-TELF1,
      END OF ITAB.
MODULE USER_COMMAND_0100 INPUT.
CASE SY-UCOMM.
   WHEN 'FIND'.
      SELECT KUNNR NAME1 LAND1 ORT01 REGIO STRAS TELF1
      INTO ITAB FROM KNA1
      WHERE KUNNR EQ KNA1-KUNNR.
      ENDSELECT.
   IF SY-SUBRC NE 0.
      MESSAGE 'CUSTOMER NOT FOUND' TYPE 'I'.
      CLEAR ITAB.
   ENDIF.
ENDCASE.

ENDMODULE.

MODULE STATUS_0200 OUTPUT.
MOVE-CORRESPONDING ITAB TO KNA1.
ENDMODULE.
