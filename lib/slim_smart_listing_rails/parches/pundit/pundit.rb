# frozen_string_literal: true

module Pundit
  module Generators
    class PolicyGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
    end
  end
end
