CLASS zcl_fabap_jul2025_exer01_pgmc DEFINITION
                                    PUBLIC
                                    FINAL
                                    CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS constructor
      IMPORTING
        i_cprod TYPE string DEFAULT 'a'
        i_nprod TYPE string DEFAULT 'b'
        i_price TYPE decfloat16 DEFAULT 0
      .

    METHODS add_stock
      IMPORTING i_stockadded TYPE i

      .

    METHODS rem_stock
      IMPORTING  i_stock_removed TYPE i
      EXPORTING  e_quant         TYPE i
      EXCEPTIONS ex_stock_removed_error
      .

    METHODS calc_val_stock
      RETURNING VALUE(r_pricestock) TYPE decfloat16.
    .

    METHODS get_codigo_produto
      RETURNING VALUE(r_cprod) TYPE string
      .

    METHODS get_nome_produto
      RETURNING VALUE(r_nprod) TYPE string
      .

    METHODS get_preco
      RETURNING VALUE(r_price) TYPE decfloat16
      .

    METHODS get_quantidade
      RETURNING VALUE(r_quant) TYPE i.
    .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gv_cprod TYPE string.
    DATA gv_nprod TYPE string.
    DATA gv_price TYPE decfloat16.
    DATA gv_quant TYPE i.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER01_PGMC IMPLEMENTATION.


  METHOD add_stock.
    gv_quant = gv_quant + i_stockadded.
  ENDMETHOD.


  METHOD calc_val_stock.
    r_pricestock = gv_price * gv_quant.
  ENDMETHOD.


  METHOD constructor.
    gv_cprod = i_cprod.
    gv_nprod = i_nprod.
    gv_price = i_price.

  ENDMETHOD.


  METHOD get_codigo_produto.
    r_cprod = gv_cprod.
  ENDMETHOD.


  METHOD get_nome_produto.
    r_nprod = gv_nprod.
  ENDMETHOD.


  METHOD get_preco.
    r_price = gv_price.
  ENDMETHOD.


  METHOD get_quantidade.
    r_quant = gv_quant.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

* Tabelas


* Estruturas


* Variáveis
    DATA o_produto1 TYPE REF TO zcl_fabap_jul2025_exer01_pgmc.

**********************************************************************
    o_produto1 = NEW #(
         i_cprod = '00012345'
         i_nprod  = 'A3000VR'
         i_price = '1500.00' ).


    out->write( 'Codigo do Produto:' ).
    out->write( o_produto1->get_codigo_produto( ) ).
    out->write( 'Nome do Produto:' ).
    out->write( o_produto1->get_nome_produto( ) ).
    out->write( 'Preço do Produto:' ).
    out->write( o_produto1->get_preco( ) ).


    CALL METHOD o_produto1->add_stock
      EXPORTING
        i_stockadded = 100.

    out->write( 'Quantidade em stock do Produto:' ).
    out->write( o_produto1->get_quantidade( ) ).


    CALL METHOD o_produto1->rem_stock
      EXPORTING
        i_stock_removed        = 20000
      EXCEPTIONS
        ex_stock_removed_error = 1
        OTHERS                 = 2.
    IF sy-subrc = 0.
      out->write( 'Quantidade removida com sucesso!' ).
    ELSE.
      out->write( 'Erro a remover, quantidade inválida' ).
      RETURN.
    ENDIF.

    CALL METHOD o_produto1->rem_stock
      EXPORTING
        i_stock_removed        = 10
      EXCEPTIONS
        ex_stock_removed_error = 1
        OTHERS                 = 2.
    IF sy-subrc = 0.
      out->write( 'Quantidade removida com sucesso!' ).
    ELSE.
      out->write( 'Erro a remover, quantidade inválida!' ).
      RETURN.
    ENDIF.

    CALL METHOD o_produto1->calc_val_stock.
    out->write( 'Preço total:' ).
    out->write( gv_quant ).
  ENDMETHOD.


  METHOD rem_stock.

    IF i_stock_removed <= gv_quant.
      gv_quant = gv_quant - i_stock_removed.

      IF e_quant IS SUPPLIED.
        e_quant = gv_quant.
      ENDIF.

    ELSE.
      MESSAGE s001(zfabap_jul2025_pgmc) WITH i_stock_removed
      DISPLAY LIKE 'E'
      RAISING ex_stock_removed_error.

    ENDIF.


  ENDMETHOD.
ENDCLASS.
