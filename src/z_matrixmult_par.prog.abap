*&---------------------------------------------------------------------*
*& Report Z_MATRIXMULT_PAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_MATRIXMULT_PAR.

DATA:
      lv_m              TYPE i VALUE 540,
      lv_n              TYPE i VALUE 540,
      lv_start_threaded TYPE i,
      lv_end_threaded   TYPE i,
      lv_difference     TYPE decfloat34,
      lo_matrix_a       TYPE REF TO zcl_matrix_par,
      lo_matrix_b       TYPE REF TO zcl_matrix_par,
      lo_matrix_c       TYPE REF TO zcl_matrix_par.

FIELD-SYMBOLS:
               <fs_line_a> TYPE zsmatrix,
               <fs_line_b> TYPE zsmatrix,
               <fs_line_c> TYPE zsmatrix.

START-OF-SELECTION.

CREATE OBJECT:
  lo_matrix_a
    EXPORTING
      iv_m = lv_m
      iv_n = lv_n,
  lo_matrix_b
    EXPORTING
      iv_m = lv_m
      iv_n = lv_n,
  lo_matrix_c
    EXPORTING
      iv_m = lv_m
      iv_n = lv_n.

CALL METHOD:
             lo_matrix_a->create_random_matrix,
             lo_matrix_b->create_random_matrix.
