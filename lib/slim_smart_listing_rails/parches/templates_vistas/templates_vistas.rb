require 'generators/slim/scaffold/scaffold_generator'

module Slim
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path(File.join('..', 'templates'), __FILE__)

      def copiar_download
        template "download.xlsx.axlsx", File.join('app', 'views', controller_file_path, "download.xlsx.axlsx")
      end

      protected
        def available_views
          ['index', 'edit', 'show', 'new', '_form', '_listing']
        end
    end
  end
end
