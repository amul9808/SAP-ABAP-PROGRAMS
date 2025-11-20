*&---------------------------------------------------------------------*
*& Module Pool       ZMDPVBAKKNA1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM ZMDPVBAKKNA1.
TABLES: VBAK,KNA1.
DATA: BEGIN OF ITAB1,
      VBELN TYPE VBAK-VBELN,
      ERDAT TYPE VBAK-ERDAT,
      NETWR TYPE VBAK-NETWR,
      WAERK TYPE VBAK-WAERK,
      KUNNR TYPE VBAK-KUNNR,
      END OF ITAB1.
DATA:   BEGIN OF ITAB2,
      KUNNR TYPE KNA1-KUNNR,
      NAME1 TYPE KNA1-NAME1,
      LAND1 TYPE KNA1-LAND1,
      ORT01 TYPE KNA1-ORT01,
      TELF1 TYPE KNA1-TELF1,
      END OF ITAB2.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
CASE SY-UCOMM.
WHEN 'FIND'.
  SELECT  VBELN ERDAT NETWR WAERK KUNNR INTO ITAB1 FROM VBAK WHERE VBELN EQ VBAK-VBELN .
    ENDSELECT.
    IF SY-SUBRC EQ 0.

      SELECT KUNNR NAME1 LAND1 ORT01 TELF1 INTO ITAB2
             FROM KNA1 WHERE KUNNR EQ ITAB1-KUNNR.
      ENDSELECT.
      ELSE.
        MESSAGE 'NOT FOUND' TYPE 'I'.
       ENDIF.
      WHEN 'EXIT'.
      LEAVE PROGRAM.


ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0201  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0201 OUTPUT.
MOVE-CORRESPONDING ITAB1 TO VBAK.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0202  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0202 OUTPUT.
MOVE-CORRESPONDING ITAB2 TO KNA1.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

ENDMODULE.
