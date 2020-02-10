module SlimSmartListingRails
  class Railtie < ::Rails::Railtie
    initializer 'slim_smart_listing_rails.monkey_patches' do |app|
      if defined? ::Rails::Generators
        require 'slim_smart_listing_rails/parches/templates_vistas/templates_vistas'
        require 'slim_smart_listing_rails/parches/template_controller/template_controller'
      end
    end

    config.after_initialize do
      unless defined? ::Rails::Generators
        require 'slim_smart_listing_rails/parches/helper_controller/helper_controller.rb'
      end
    end
  end
end
