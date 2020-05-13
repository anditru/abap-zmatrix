FUNCTION Z_CALC_VALUES.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_MATRIX_A) TYPE  ZTMATRIX_PAR
*"     VALUE(IT_MATRIX_B) TYPE  ZTMATRIX_PAR
*"     VALUE(IV_M) TYPE  INT4
*"     VALUE(IV_N) TYPE  INT4
*"     VALUE(IV_NR_WP) TYPE  INT4
*"     VALUE(IV_START) TYPE  INT4
*"  EXPORTING
*"     VALUE(ET_RESULT) TYPE  ZTMATRIX_PAR
*"----------------------------------------------------------------------

DATA:
      lt_matrix_a    TYPE ztmatrix_par_hash,
      lt_matrix_b    TYPE ztmatrix_par_hash,
      lv_count       TYPE i,
      ls_line_result TYPE zsmatrix_par,
      lv_i           TYPE i VALUE 1,
      lv_j           TYPE i,
      lv_key         TYPE i VALUE 1.

FIELD-SYMBOLS:
               <fs_line_result> TYPE zsmatrix_par,
               <fs_line_a>      TYPE zsmatrix_par,
               <fs_line_b>      TYPE zsmatrix_par.

lt_matrix_a = it_matrix_a.
lt_matrix_b = it_matrix_b.

ASSIGN ls_line_result TO <fs_line_result>.
lv_count = iv_start.
lv_j = iv_start.

WHILE lv_i <= iv_m.
  WHILE lv_j <= iv_n.
    <fs_line_result>-key = lv_key.
    <fs_line_result>-m = lv_i.
    <fs_line_result>-n = lv_j.
    INSERT <fs_line_result> INTO TABLE et_result.
    lv_key = lv_key + iv_nr_wp.
    lv_j = lv_j + iv_nr_wp.
  ENDWHILE.
  lv_j = iv_start.
  lv_i = lv_i + 1.
ENDWHILE.

LOOP AT et_result ASSIGNING <fs_line_result>.
  LOOP AT lt_matrix_a ASSIGNING <fs_line_a> USING KEY m_sort WHERE m = <fs_line_result>-m.
    READ TABLE lt_matrix_b WITH KEY primary_key COMPONENTS m = <fs_line_a>-n n = <fs_line_result>-n ASSIGNING <fs_line_b>.
    <fs_line_result>-value = <fs_line_result>-value + ( <fs_line_a>-value * <fs_line_b>-value ).
  ENDLOOP.
ENDLOOP.

ENDFUNCTION.
