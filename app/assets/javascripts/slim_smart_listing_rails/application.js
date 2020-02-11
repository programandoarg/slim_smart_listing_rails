window.SlimSmartListingRails = new function() {
  this.bindear = function() {
    $.fn.datepicker.defaults.format = 'dd/mm/yyyy';
    $('.datefield').datepicker({
      'format': 'dd/mm/yyyy',
      'todayBtn': 'linked',
      'autoclose': 'true',
      'language': 'es',
      'zIndexOffset': 2000,
    });
    $('select[multiple=multiple]').selectize();
  }
}
