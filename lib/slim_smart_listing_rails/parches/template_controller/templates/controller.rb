# generado con https://github.com/programandoarg/slim_smart_listing_rails

<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "<%= plural_name.humanize %>", :<%= plural_table_name %>_path

  def index
    @filtros = SlimSmartListingRails::FiltrosBuilder.new(
      self, <%= class_name %>, [<%= attributes_names.map{|nombre| ":#{nombre}" }.join(', ') %>])
    @<%= plural_table_name %> = @filtros.filtrar <%= orm_class.all(class_name) %>

    respond_to do |format|
      format.json { render json: @<%= plural_table_name %> }
      format.js { render_smart_listing }
      format.html { render_smart_listing }
    end
  end

  def show
    add_breadcrumb @<%= singular_table_name %>, @<%= singular_table_name %>
    @<%= singular_table_name %> = @<%= singular_table_name %>.decorate
  end

  def new
    add_breadcrumb <%= "'Crear #{human_name}'" %>

    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    @<%= singular_table_name %> = @<%= singular_table_name %>.decorate
  end

  def edit
    add_breadcrumb @<%= singular_table_name %>
    @<%= singular_table_name %> = @<%= singular_table_name %>.decorate
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} creado/a.'" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} actualizado/a.'" %>
    else
      render :edit
    end
  end

  def destroy
    destroy_and_respond(@<%= orm_instance.destroy %>, <%= index_helper %>_url)
  end

  private

    def render_smart_listing
<% if namespaced? -%>
      smart_listing(:<%= plural_table_name %>, @<%= plural_table_name %>, '<%= namespaced_path %>/<%= plural_table_name %>/listing')
<% else -%>
      smart_listing(:<%= plural_table_name %>, @<%= plural_table_name %>, '<%= plural_table_name %>/listing')
<% end -%>
    end

    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
