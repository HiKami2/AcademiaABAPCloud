CLASS zcl_fabap_jul2025_exer02_pgmc3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_PGMC3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA o_func1 TYPE REF TO zcl_fabap_jul2025_exer02_pgmc.
    DATA o_func2 TYPE REF TO zcl_fabap_jul2025_exer02_pgmc1.
    DATA o_func3 TYPE REF TO zcl_fabap_jul2025_exer02_pgmc2.

    o_func2 = NEW #( i_id = '01' i_nome = 'Pedro Manuel Ferreira Bonati' i_salario_base = '1500' i_bonus = '500' ).

    out->write( 'Salário do Funcionário Integral:' ).
    out->write( o_func2->calcular_salario(  ) ).

    out->write( 'Dados do Funcionário Integral:' ).
    out->write( o_func2->exibir_dados(  ) ).

    out->write( '--------------------------------------------------' ).
    out->write( '--------------------------------------------------' ).


    o_func3 = NEW #( i_id = '02' i_nome = 'Joao Carvalho' i_salario_base = '1500' i_horas = '1' ).


    out->write( 'Salário do Funcionário Horista:' ).
    out->write( o_func3->calcular_salario(  ) ).

    out->write( 'Dados do Funcionário Horista:' ).
    out->write( o_func3->exibir_dados(  ) ).
  ENDMETHOD.
ENDCLASS.
