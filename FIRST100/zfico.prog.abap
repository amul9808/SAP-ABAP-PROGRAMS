*&---------------------------------------------------------------------*
*& Module Pool       ZFICO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM ZFICO.
TABLES:BSAS,SKA1,SKAT.
DATA: BEGIN OF ITAB1 OCCURS 0,
         BUKRS TYPE BSAS-BUKRS,
         AUGDT TYPE BSAS-AUGDT,
         BUDAT TYPE BSAS-BUDAT,
         HKONT TYPE BSAS-HKONT,
         GJAHR TYPE BSAS-GJAHR,
         DMBTR TYPE BSAS-DMBTR,
      END OF ITAB1.
DATA: BEGIN OF ITAB2 OCCURS 0,
         KTOPL TYPE SKA1-KTOPL,
         SAKNR TYPE SKA1-SAKNR,
         TXT20 TYPE SKAT-TXT20,
     END OF ITAB2.
DATA: ACCOUNTS TYPE SKA1-KTOPL,
      DESCRIPTION TYPE SKAT-TXT20.
MODULE USER_COMMAND_0100 INPUT.
CASE SY-UCOMM.
    WHEN 'FIND'.
      SELECT BUKRS AUGDT BUDAT HKONT GJAHR DMBTR
      INTO ITAB1 FROM BSAS
      WHERE BUKRS EQ BSAS-BUKRS AND BUDAT EQ BSAS-BUDAT AND GJAHR EQ BSAS-GJAHR.
      ENDSELECT.
   IF SY-SUBRC EQ 0.
      SELECT A~KTOPL A~SAKNR B~TXT20
      INTO TABLE ITAB2 FROM
      SKA1 AS A
      INNER JOIN
      SKAT AS B
      ON A~SAKNR EQ B~SAKNR
      AND A~KTOPL EQ B~KTOPL
      AND B~SPRAS EQ SY-LANGU
      WHERE A~KTOPL EQ B~KTOPL.
   ELSE.
   MESSAGE 'ACCOUNT NOT FOUND' TYPE 'I'.
   CLEAR ITAB1.
   CLEAR ITAB2.
ENDIF.
   WHEN 'EXIT'.
      LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
  MOVE-CORRESPONDING ITAB1 TO BSAS.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0201  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0201 OUTPUT.
   MOVE-CORRESPONDING ITAB2 TO SKA1.
ENDMODULE.
