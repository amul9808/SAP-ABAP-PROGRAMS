*&---------------------------------------------------------------------*
*& Report ZFOODCOURTPRG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFOODCOURTPRG.

DATA: VCSTNAME TYPE ZFOODCOURT-CSTNAME,
      VPRDTNAME TYPE ZFOODCOURT-PRDTNAME,
      VQTTY TYPE ZFOODCOURT-QTTY,
      VPRICE TYPE ZFOODCOURT-PRICE,
      VCRTDON TYPE ZFOODCOURT-CRTDON,
      VCRTDTM TYPE ZFOODCOURT-CRTDTM.
PARAMETERS SALESID TYPE ZFOODCOURT-SALESID OBLIGATORY.
                    CALL FUNCTION 'ZFOODCOURTFM'
                      EXPORTING
                        FMD_SALESID       = SALESID
                     IMPORTING
                       FMD_CSTNAME        = VCSTNAME
                       FMD_PRDTNAME       = VPRDTNAME
                       FMD_QTTY           = VQTTY
                       FMD_PRICE          = VPRICE
                       FMD_CRTDON         = VCRTDON
                       FMD_CRTDTM         = VCRTDTM
                     EXCEPTIONS
                       NOTFOUND           = 1
                       OTHERS             = 2.
         CASE SY-SUBRC.
          WHEN 0.
            PERFORM SUBRC_OUTPUT.
          WHEN 1.
            MESSAGE 'CUSTOMER DATA NOT FOUND ' TYPE 'A'.
          WHEN 2.
            MESSAGE 'TRY AGAIN' TYPE 'S'.
            ENDCASE.

FORM SUBRC_OUTPUT.
  WRITE:/5 'SALES ID', SALESID COLOR 1,
        /5 'CUSTOMER NAME', VCSTNAME COLOR 2,
        /5 'QUANTITY ', VQTTY COLOR 3,
        /5 'PRICE    ', VPRICE COLOR 4,
        /5 'CREATED ON DATE'   , VCRTDON COLOR 5,
        /5 'CREATED ON TIME' , VCRTDTM COLOR 6.
  ENDFORM.
