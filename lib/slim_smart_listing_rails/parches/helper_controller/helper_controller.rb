ActionController::Base.class_eval do
  include Pundit
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  prepend_view_path File.expand_path(File.join('../../../vistas_compartidas'), __FILE__)

  protected
    def smart_listing(smart_listing_key, scope, partial)
      smart_listing_create smart_listing_key, scope, partial: partial, default_sort: { id: :desc }
      if params["#{smart_listing_key}_smart_listing"].present?
        render partial: 'actualizar_smart_listing', locals: { smart_listing_key: smart_listing_key },
               layout: false, content_type: 'text/javascript'
      end
    end

    def destroy_and_respond(model, redirect_url = nil)
      if destroy_model(model)
        respond_to do |format|
          format.html do
            if redirect_url.present?
              redirect_to redirect_url, notice: 'Elemento borrado.'
            else
              redirect_back(fallback_location: root_path, notice: 'Elemento borrado.')
            end
          end
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html do
            if model.respond_to?(:associated_elements) && model.associated_elements.present?
              @model = model
              render destroy_error_details_view
            else
              flash[:error] = @error_message
              if redirect_url.present?
                redirect_to redirect_url
              else
                redirect_back(fallback_location: root_path)
              end
            end
          end
          format.json { render json: { error: @error_message }, status: :unprocessable_entity }
        end
      end
    end

    def destroy_error_details_view
      'destroy_error_details'
    end

    def destroy_model(model)
      @error_message = 'No se pudo eliminar el registro'
      begin
        model.destroy
        return true
      rescue ActiveRecord::InvalidForeignKey => e
        # class_name = /from table \"(?<table_name>[\p{L}_]*)\"/.match(e.message)[:table_name].singularize.camelcase
        # # pk_id = /from table \"(?<pk_id>[\p{L}_]*)\"/.match(e.message)[:pk_id].singularize.camelcase
        # clazz = Object.const_get class_name
        # objects = clazz.where(model.class.table_name.singularize => model)
        model_name = t("activerecord.models.#{model.class.name.underscore}")
        @error_message = "#{model_name} no se pudo borrar porque tiene elementos asociados."
        logger.debug e.message
      end
      false
    end
end
