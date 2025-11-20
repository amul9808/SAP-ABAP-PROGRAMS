*&---------------------------------------------------------------------*
*& Module Pool       ZDDKNA1CUST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
PROGRAM ZDDKNA1CUST.

TABLES: KNA1,VBAK.
DATA: BEGIN OF ITAB OCCURS 0,
    VBELN TYPE VBAK-VBELN,
     END OF ITAB.

DATA: BEGIN OF dulheraja OCCURS 0,
        vbeln TYPE vbak-vbeln,
        erdat TYPE vbak-erdat,
        netwr TYPE vbak-netwr,
        waerk TYPE vbak-waerk,
        vkorg TYPE vbak-vkorg,
        name1 TYPE kna1-name1,
        land1 TYPE kna1-land1,
        ort01 TYPE kna1-ort01,
        telf1 TYPE kna1-telf1,
      END OF dulheraja.

DATA: gv_vbeln TYPE vbak-vbeln. "Global variable for screen input
MODULE CUSTOMER INPUT.
SELECT VBELN INTO TABLE ITAB FROM VBAK WHERE KUNNR EQ KNA1-KUNNR.
IF SY-SUBRC NE 0.
   MESSAGE 'CUSTOMER NOT FOUND' TYPE 'I'.
   CLEAR ITAB.
ELSE.
CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
  EXPORTING
    RETFIELD               = 'VBELN'
   DYNPPROG               = 'ZDDKNA1CUST'
   DYNPNR                 = '0100'
   DYNPROFIELD            = 'VBAK-VBELN'
   VALUE_ORG              = 'S'
  TABLES
    VALUE_TAB             = ITAB

 EXCEPTIONS
   PARAMETER_ERROR        = 1
   NO_VALUES_FOUND        = 2
   OTHERS                 = 3.
ENDIF.
IF SY-SUBRC <> 0.
MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO WITH
           SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'FIND'.
      gv_vbeln = vbak-vbeln.   "Take the value entered on screen 0100
      CALL SCREEN '0200'.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  CLEAR dulheraja.

  SELECT a~vbeln a~erdat a~netwr a~waerk a~vkorg
         b~name1 b~land1 b~ort01 b~telf1
    INTO CORRESPONDING FIELDS OF TABLE dulheraja
    FROM vbak AS a
    INNER JOIN kna1 AS b
       ON a~kunnr = b~kunnr
   WHERE a~vbeln = gv_vbeln.

  IF sy-subrc <> 0.
    MESSAGE 'DATA NOT FOUND' TYPE 'S'.
  ENDIF.

  CASE sy-ucomm.
    WHEN 'BACK'.
      CALL SCREEN '0100'.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
