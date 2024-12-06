class ZCL_OTEL_TRACE_PROCESSOR_EPP definition
  public
  final
  create public .

public section.

  interfaces ZIF_OTEL_TRACE_PROCESSOR .

  class-methods CLASS_CONSTRUCTOR .
  protected section.
  private section.
    class-data epp_attributes type zif_otel_attribute_map=>entries_tt.
ENDCLASS.



CLASS ZCL_OTEL_TRACE_PROCESSOR_EPP IMPLEMENTATION.


  method class_constructor.
    try.
        data(lo_epp) = cl_epp_global_factory=>get_section( ).
        epp_attributes = value #(
            ( name = 'sap.connection_id' value = lo_epp->get_connection_id_as_uuid( ) )
            ( name = 'sap.transaction_id' value = lo_epp->get_transaction_id( ) )
            ( name = 'sap.context_id' value = lo_epp->get_root_context_id_as_uuid( ) )
        ).
      catch cx_epp_error.    "
    endtry.
  endmethod.


  method zif_otel_trace_processor~on_span_end.
  endmethod.


  method zif_otel_trace_processor~on_span_event.
  endmethod.


  method zif_otel_trace_processor~on_span_start.
    " if we add in the beginning - then we don't care of the sequence of plugins
    " span is sent on end, not start
    try.
        span->attributes( )->append( epp_attributes ).
      catch cx_epp_error.    "
    endtry.
  endmethod.
ENDCLASS.
