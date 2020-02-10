module Rails
  module Generators
    class ScaffoldControllerGenerator < NamedBase
      source_root File.expand_path(File.join('..', 'templates'), __FILE__)

      hook_for :decorator, type: :boolean, default: true
    end
  end
end

require 'generators/rails/decorator_generator'

module Rails
  module Generators
    class DecoratorGenerator < NamedBase
      # source_root File.expand_path("templates", __dir__)
      # check_class_collision suffix: "Decorator"

      # class_option :parent, type: :string, desc: "The parent class for the generated decorator"

      # def create_decorator_file
      #   template 'decorator.rb', File.join('app/decorators', class_path, "#{file_name}_decorator.rb")
      # end

      # hook_for :test_framework

      private

      def parent_class_name
        "SlimSmartListingRails::BaseDecorator"
      end
    end
  end
end
