*&---------------------------------------------------------------------*
*& Include ZFOODCOURTTOP_TOP                                 Module Pool      ZFOODCOURTTOP
*&
*&---------------------------------------------------------------------*
PROGRAM ZFOODCOURTTOP.
TABLES : ZFOODCOURT.
DATA: BEGIN OF ITAB.
    INCLUDE STRUCTURE ZFOODCOURT.
DATA: END OF ITAB.
DATA: OKCODE TYPE SY-UCOMM.
