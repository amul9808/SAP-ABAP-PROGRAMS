
REPORT ZCLASSICALREP
   NO STANDARD PAGE HEADING
   LINE-SIZE 500
   LINE-COUNT 24(3)
   MESSAGE-ID ZB11A_MSGCLASS.
*declarations
   TYPES : BEGIN OF TYPE1,
             KUNNR TYPE VBAK-KUNNR,
             VBELN TYPE VBAK-VBELN,
             ERDAT TYPE VBAK-ERDAT,
             WAERK TYPE VBAK-WAERK,
             NETWR TYPE VBAK-NETWR,
           END OF TYPE1.
   DATA : ITAB TYPE TABLE OF TYPE1,
          WA   TYPE TYPE1.
   DATA   V1 TYPE KNA1-KUNNR.

   DATA : STOTAL TYPE VBAK-NETWR,
          GTOTAL TYPE VBAK-NETWR.
*Input
   SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE T1.
       SELECT-OPTIONS CUSTOMER FOR V1 ."OBLIGATORY.
   SELECTION-SCREEN END OF BLOCK B1.
   INITIALIZATION.
   T1 = 'Sold to party Sales classical report'.

*Process
   START-OF-SELECTION.
     PERFORM SUBR_OPENSQL.
*page Headings
   TOP-OF-PAGE.
     WRITE:/ 'Date '  , SY-DATUM COLOR 4, 'Time ' , SY-TIMLO COLOR 4,
          80 'PageNo' , SY-PAGNO COLOR 4.
     WRITE:/25 'Sold to Party From :  ' , CUSTOMER-LOW , 'to' , CUSTOMER-HIGH , ' Orders list'.
     SKIP.
     ULINE.
     WRITE:/5 'Order No' COLOR 2, 30 'Order Date' COLOR 2,
           55 'Currency' COLOR 3, 70 'Net Value ' COLOR 3.
     ULINE.

   END-OF-PAGE.
     ULINE AT /70(20).
     WRITE:/70 '|' , 75 'End of Page' COLOR 6 , 89 '|'.
     ULINE AT /70(20).

*Output
   END-OF-SELECTION.
     CASE SY-SUBRC.
        WHEN 0.
          PERFORM SUBR_OUTPUT.
        WHEN 4.
          MESSAGE S003.
     ENDCASE.
*get sales orders
FORM SUBR_OPENSQL .
     SELECT KUNNR VBELN ERDAT WAERK NETWR
            INTO TABLE ITAB FROM VBAK
            WHERE KUNNR IN CUSTOMER.
ENDFORM.

*Order list
FORM SUBR_OUTPUT .
     SORT ITAB BY KUNNR.
     LOOP AT ITAB INTO WA.
          AT NEW KUNNR.
             WRITE:/ 'Sold to Party' COLOR 4 , WA-KUNNR COLOR 3.
          ENDAT.
*         print sales
          WRITE:/5 WA-VBELN COLOR 2, 30 WA-ERDAT COLOR 2,
                55 WA-WAERK COLOR 3, 70 WA-NETWR COLOR 3.
          ADD WA-NETWR TO STOTAL.
*         change of Sold to party : display Subtotal of sold to party
          AT END OF KUNNR.
             WRITE:/5 'Sold to party Sales total' COLOR 4, 65 STOTAL COLOR 3.
             ADD STOTAL TO GTOTAL.
             STOTAL = 0.  "calculate next sold to party sales subtotal
             NEW-PAGE.
          ENDAT.
*         print grand total
          AT LAST.
          WRITE:/5 'All Sales total' COLOR 4, 65 GTOTAL COLOR 3.

          ENDAT.
     ENDLOOP.
ENDFORM.
