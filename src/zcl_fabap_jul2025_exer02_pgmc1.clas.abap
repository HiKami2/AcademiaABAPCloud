CLASS zcl_fabap_jul2025_exer02_pgmc1 DEFINITION
  PUBLIC
  INHERITING FROM zcl_fabap_jul2025_exer02_pgmc
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_nome         TYPE string
        i_id           TYPE string
        i_salario_base TYPE decfloat16
        i_bonus        TYPE decfloat16
      .

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: gv_bonus TYPE decfloat16.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_PGMC1 IMPLEMENTATION.


  METHOD calcular_salario.

    rv_salario = gv_salario_base + gv_bonus.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( i_nome = i_nome
                        i_id = i_id
                        i_salario_base = i_salario_base ).
    gv_bonus = i_bonus.

  ENDMETHOD.
ENDCLASS.
