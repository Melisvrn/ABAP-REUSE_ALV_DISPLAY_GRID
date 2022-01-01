*&---------------------------------------------------------------------*
*& Report ZFIRST_STUDY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFIRST_STUDY.

"Kullanılacak tablolar tanımlandı.
TABLES : MARA,
         MARD,
         MARC.

DATA: BEGIN OF GT_ITAB OCCURS 0,
        MATNR TYPE MARA-MATNR,
        WERKS TYPE MARD-WERKS,
        LGORT TYPE MARD-LGORT,
        MTART TYPE MARA-MTART,
        LABST TYPE MARD-LABST,
        SPEME TYPE MARD-SPEME,
        SONUC TYPE I,
        ICON  TYPE CHAR4,
      END OF GT_ITAB.

DATA: GS_ITAB LIKE LINE OF GT_ITAB.
DATA    IS_LAYOUT    TYPE SLIS_LAYOUT_ALV.
DATA: FIELDCATALOG TYPE SLIS_T_FIELDCAT_ALV WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK 100 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS : S_MATNR  FOR MARA-MATNR  .
SELECT-OPTIONS : S_WERKS  FOR  MARC-WERKS NO INTERVALS NO-EXTENSION DEFAULT 1000 .
SELECTION-SCREEN END OF BLOCK 100.

START-OF-SELECTION.
  
  PERFORM GET_DATA.
  PERFORM FIELDCATALOG.
  PERFORM DISPLAY.
  PERFORM EXIT_CONFIRM_SCREEN.

*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .
  SELECT MARD~WERKS MARD~LGORT MARA~MTART MARD~LABST MARD~SPEME MARA~MATNR
  FROM MARA INNER JOIN MARC
  ON MARA~MATNR EQ MARC~MATNR
  INNER JOIN MARD ON MARC~MATNR EQ MARD~MATNR
  AND MARC~WERKS EQ MARD~WERKS
  INTO CORRESPONDING FIELDS OF TABLE  GT_ITAB
  WHERE MARA~MATNR IN S_MATNR
  AND   MARD~WERKS IN S_WERKS.
  SORT GT_ITAB BY SPEME DESCENDING.
  "Sort Descending : Belirtilen sütundaki değerleri büyükten küçüğe doğru sıralar. Inner join: İki tabloyu birleştirir.

  LOOP AT GT_ITAB INTO GS_ITAB.
    GS_ITAB-SONUC = GS_ITAB-LABST  - GS_ITAB-SPEME .
    MODIFY  GT_ITAB FROM GS_ITAB .
    CLEAR GS_ITAB.

  ENDLOOP.

  "shift gs_itab-matnr left deleting leading '0': Elde edilen değerin solundaki sıfırların silinmesini sağlar.
  LOOP AT GT_ITAB INTO GS_ITAB.
    IF GS_ITAB-SONUC <= 0.
      GS_ITAB-ICON = '@0A@'.
    ELSE.
      GS_ITAB-ICON = '@08@'.
    ENDIF.
    SHIFT GS_ITAB-MATNR LEFT DELETING LEADING '0'.
    MODIFY  GT_ITAB FROM GS_ITAB TRANSPORTING ICON MATNR.
    CLEAR GS_ITAB.
  ENDLOOP.

  SELECT SINGLE * FROM MARA
  WHERE MATNR EQ S_MATNR.
  IF  S_MATNR IS INITIAL.
    MESSAGE ' UYARI !!  Malzeme Numarası Girilmeden Malzeme Görüntülenemez ' TYPE 'I'.
    STOP.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  EXIT_CONFIRM_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM EXIT_CONFIRM_SCREEN .
  DATA ANS.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = 'Onay Ekranı'
      TEXT_QUESTION         = 'Çıkış Yapmak İstiyor Musunuz? '
      TEXT_BUTTON_1         = 'Evet'
      ICON_BUTTON_1         = 'ICON_CHECKED'
      TEXT_BUTTON_2         = 'Hayır'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DISPLAY_CANCEL_BUTTON = ' '
      POPUP_TYPE            = 'ICON_MESSAGE_ERROR'
    IMPORTING
      ANSWER                = ANS.

  IF ANS EQ 1.
*  set screen 0.
*  leave screen.
  ELSE.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  FIELDCATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDCATALOG .
  FIELDCATALOG-FIELDNAME = 'werks'.
  FIELDCATALOG-SELTEXT_M = 'Üretim Yeri'.
  FIELDCATALOG-COL_POS  = 0.
  IS_LAYOUT-ZEBRA = 'X'.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

  FIELDCATALOG-FIELDNAME = 'matnr'.
  FIELDCATALOG-SELTEXT_M = 'Malzeme Numarası'.
  FIELDCATALOG-COL_POS  = 1.
  "fieldcatalog-no_zero = 'X'.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

  FIELDCATALOG-FIELDNAME = 'mtart'.
  FIELDCATALOG-SELTEXT_M = 'Malzeme Türü'.
  FIELDCATALOG-COL_POS  = 2.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.


  FIELDCATALOG-FIELDNAME = 'lgort'.
  FIELDCATALOG-SELTEXT_M = 'Depo Yeri'.
  FIELDCATALOG-COL_POS  = 3.
  "fieldcatalog-no_zero = 'X'.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

  FIELDCATALOG-FIELDNAME = 'labst'.
  FIELDCATALOG-SELTEXT_M = 'Tahditsiz Stok'.
  FIELDCATALOG-COL_POS  = 4.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

  FIELDCATALOG-FIELDNAME = 'speme'.
  FIELDCATALOG-SELTEXT_M = 'Bloke Stok'.
  FIELDCATALOG-COL_POS  = 5.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

  FIELDCATALOG-FIELDNAME = 'sonuc'.
  FIELDCATALOG-SELTEXT_M = 'Sonuc'.
  FIELDCATALOG-COL_POS  = 6.
  FIELDCATALOG-NO_OUT = 'X'.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.


  FIELDCATALOG-FIELDNAME = 'icon'.
  FIELDCATALOG-SELTEXT_M = 'Icon'.
  FIELDCATALOG-COL_POS  = 7.
  FIELDCATALOG-ICON = 'X'.
*  fieldcatalog-tabname = 'GT_ITAB'.
  APPEND FIELDCATALOG TO FIELDCATALOG.
  CLEAR FIELDCATALOG.

*  fieldcatalog-fieldname = Alan Adı.
*  fieldcatalog-seltext_m = Alana verilen medium isim
*  fieldcatalog-col_pos  = Alanın kaçınca sütunda yer alacağı
*  fieldcatalog-no_out = 'X'. = Görüntüde alanı gizler ama kullanıcı istediği zaman bu alanı görüntüleyebilir.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      IS_LAYOUT   = IS_LAYOUT
      IT_FIELDCAT = FIELDCATALOG[]
    TABLES
      T_OUTTAB    = GT_ITAB.

ENDFORM.
