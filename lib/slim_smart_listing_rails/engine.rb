require 'slim_smart_listing_rails/simple_form/inputs/fecha_input'
require 'slim_smart_listing_rails/base_decorator'

module SlimSmartListingRails
  class Engine < ::Rails::Engine
    # config.generators do |g|
    #   g.test_framework :rspec
    #   g.fixture_replacement :factory_bot
    #   g.factory_bot dir: 'spec/factories'
    # end
    initializer "modulo_compras.factories", :after => "factory_bot.set_factory_paths" do
      if defined? ::Rails::Generators
        require 'slim_smart_listing_rails/parches/factory_bot'
      end
    end
    config.after_initialize do
      if defined? ::Rails::Generators
        require 'slim_smart_listing_rails/parches/templates_vistas/templates_vistas'
        require 'slim_smart_listing_rails/parches/template_controller/template_controller'
      else
        require 'slim_smart_listing_rails/simple_form/initializer'
        require 'slim_smart_listing_rails/parches/helper_controller/helper_controller'
      end
      # unless defined? ::Rails::Generators
      # end
    end
  end
end
