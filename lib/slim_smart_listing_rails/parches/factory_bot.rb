# require "factory_bot_rails"
# require "factory_bot"
require "generators/factory_bot"

module FactoryBot
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:
      def class_name_hack
        (namespaced_class_path + [file_name]).map!(&:camelize).join("::")
      end

      def explicit_class_option
        return if class_name_hack == singular_table_name.camelize

        ", class: '#{class_name_hack}'"
      end
    end
  end
end


require "generators/factory_bot/model/model_generator"

module FactoryBot
  module Generators
    class ModelGenerator < Base

      private

      def create_factory_file
        file = File.join("spec/factories", "#{filename}.rb")
        template "factories.erb", file
      end

      def factory_attributes
        attributes.map do |attribute|
          "#{attribute.name} { #{valor_atributo(attribute)} }"
        end.join("\n")
      end

      def valor_atributo(attribute)
        if attribute.type == :string
          "Faker::Lorem.sentence"
        elsif attribute.type == :date
          "Faker::Date.backward"
        else
          # byebug
          attribute.default.inspect
        end
      end
    end
  end
end


# FactoryBot::Generators::ModelGenerator.class_eval do

#   private

#   def factory_attributes
#     attributes.map do |attribute|
#       "#{attribute.name} { Faker::Lorem.sentence }"
#     end.join("\n")
#   end
# end
