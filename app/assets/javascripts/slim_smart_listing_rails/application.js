window.SlimSmartListingRails = new function() {
  self = this
  self.campo_dependiente_hacer = function(principal, dependiente, valor) {
    if( principal.val() == valor ) {
      dependiente.closest('.form-group').removeClass('ocultar')
    } else {
      dependiente.closest('.form-group').addClass('ocultar')
    }
  }
  self.encolumnar = function(principal, dependiente) {
    var fila = $('<div class="row">');
    fila = fila.insertBefore(principal.closest('.form-group'));
    var col1 = $('<div class="col-sm-6">');
    var col2 = $('<div class="col-sm-6">');
    col1.append(principal.closest('.form-group'));
    col2.append(dependiente.closest('.form-group'));
    fila.append(col1);
    fila.append(col2);
  }
  self.campo_dependiente = function(campo, depende_de, valor) {
    var principal = $('form.simple_form *[name*=' + depende_de + ']');
    var dependiente = $('form.simple_form *[name*=' + campo + ']');
    self.encolumnar(principal, dependiente)
    principal.change(function() {
      self.campo_dependiente_hacer(principal, dependiente, valor);
    })
    self.campo_dependiente_hacer(principal, dependiente, valor);
  }
  self.bindear = function() {
    $.fn.datepicker.defaults.format = 'dd/mm/yyyy';
    $('.datefield').datepicker({
      'format': 'dd/mm/yyyy',
      'todayBtn': 'linked',
      'autoclose': 'true',
      'language': 'es',
      'zIndexOffset': 2000,
    });
    $('select[multiple=multiple]').selectize();
    $('form').dependent_fields();
    $('.exportar').click(function() {
      filtros = ''
      $('.filter').each(function(i, elem) {
        var input = $(elem).find('input,select');
        filtros += input.attr('name') + '=' + input.val() + '&'
      });

      var url_get = $(this).data('url') + "?"+filtros;
      window.location.href = url_get;
    })
  }

  self.insert_options = function(element, options, default_option, template_id, atributo_nombre) {
    if (options.length === 0) {
      default_option = '-';
    }

    var template_html;
    if( template_id != null ) {
      template_html = $(template_id).html();
    } else {
      template_html = '<option value="">{{default_option}}</option>{{#each array}}<option value="{{id}}">{{' + atributo_nombre + '}}</option>{{/each}}'
    }
    var template = Handlebars.compile(template_html);
    element.html(template({array: options, default_option: default_option}));
    element.trigger("chosen:updated");
  }

  window.jQuery.fn.dependent_fields = function() {
    var that = this;

    var update_dependent = function() {
      var target = this;
      var options = {};
      options[$(target).data('key')] = $(this).val();
      $.getJSON($(target).data('url'), options)
      .done(function(response) {
        var id = $(target).data('id')
        var siguiente_select = $("[data-id='"+id+"'] ~ select").first();
        self.insert_options(siguiente_select, response, 'Seleccione una opción', null, 'nombre');
        $(siguiente_select).trigger('change');
      }).fail(function(response) { });
    }

    var bind_events = function(target) {
      var main = $(target).find('select').last();
      var selectores = $(target).find('select').not(main); // Todos menos el último
      $(selectores).each(function(i, selector) {
        $(selector).on('change', update_dependent);
      })
    }

    // TODO: Polemic
    $(that).on('nested:fieldAdded', function(event){
      var field = event.field;
      bind_events(field);
    });

    $(that).find('.form-group.dependent_fields').each(function(i, field) {
      bind_events(field);
    })
  }
}

