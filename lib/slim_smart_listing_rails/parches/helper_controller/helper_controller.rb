ActionController::Base.class_eval do
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  protected
    def smart_listing(smart_listing_key, scope, partial)
      prepend_view_path File.expand_path(File.join('../../../vistas_compartidas'), __FILE__)
      smart_listing_create smart_listing_key, scope, partial: partial
      if params["#{smart_listing_key}_smart_listing"].present?
        render partial: 'actualizar_smart_listing', locals: { smart_listing_key: smart_listing_key },
               layout: false, content_type: 'text/javascript'
      end
    end
end
