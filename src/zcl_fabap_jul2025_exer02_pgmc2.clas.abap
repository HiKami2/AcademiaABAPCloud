CLASS zcl_fabap_jul2025_exer02_pgmc2 DEFINITION
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
        i_horas        TYPE i
      .

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: gv_horas TYPE i.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_PGMC2 IMPLEMENTATION.


  METHOD calcular_salario.

    rv_salario = gv_salario_base * gv_horas.

  ENDMETHOD.


  METHOD constructor.

    super->constructor( i_nome = i_nome
                        i_id = i_id
                        i_salario_base = i_salario_base ).
    gv_horas = i_horas.

  ENDMETHOD.
ENDCLASS.
