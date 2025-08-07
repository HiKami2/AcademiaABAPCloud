CLASS zcl_fabap_jul2025_exer02_pgmc DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        i_nome         TYPE string
        i_id           TYPE string
        i_salario_base TYPE decfloat16
      .

    METHODS calcular_salario
      RETURNING VALUE(rv_salario) TYPE decfloat16.

    METHODS exibir_dados
      RETURNING VALUE(rv_dados) TYPE string.

  PROTECTED SECTION.
    DATA: gv_nome         TYPE string,
          gv_id           TYPE string,
          gv_salario_base TYPE decfloat16.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_PGMC IMPLEMENTATION.


  METHOD calcular_salario.
    rv_salario = gv_salario_base.
  ENDMETHOD.


  METHOD constructor.

    gv_nome = i_nome.
    gv_id = i_id.
    gv_salario_base = i_salario_base.

  ENDMETHOD.


  METHOD exibir_dados.
    rv_dados = |ID: { gv_id }, Nome: { gv_nome }, Salário Base: { gv_salario_base }|.
  ENDMETHOD.
ENDCLASS.
