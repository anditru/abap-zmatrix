*&---------------------------------------------------------------------*
*& Report Z_MATRIXMULT_PAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_MATRIXMULT_PAR.

DATA:
      lv_m              TYPE i VALUE 540,
      lv_n              TYPE i VALUE 540,
      lv_nr_wp          TYPE i VALUE 4,
      lv_count          TYPE i VALUE 1,
      lv_count_char     TYPE c LENGTH 3,
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

GET RUN TIME FIELD lv_start_threaded.

DO lv_nr_wp TIMES.
  lv_count_char = lv_count.
  CALL FUNCTION 'Z_CALC_VALUES'
    STARTING NEW TASK lv_count_char
    CALLING lo_matrix_c->receive_values ON END OF TASK
    EXPORTING
      it_matrix_a = lo_matrix_a->matrix
      it_matrix_b = lo_matrix_b->matrix
      iv_m = lv_m
      iv_n = lv_n
      iv_nr_wp = lv_nr_wp
      iv_start = lv_count.
  lv_count = lv_count + 1.
ENDDO.

WAIT UNTIL lo_matrix_c->tasks_finished = lv_count.

GET RUN TIME FIELD lv_end_threaded.
lv_difference = CONV decfloat34( ( lv_end_threaded - lv_start_threaded ) / 1000000 ).
WRITE: lv_difference, ' s for threaded calculation'.
