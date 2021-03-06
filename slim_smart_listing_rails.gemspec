$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "slim_smart_listing_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "slim_smart_listing_rails"
  spec.version     = SlimSmartListingRails::VERSION
  spec.authors     = ["Martín Rosso"]
  spec.email       = ["mrosso10@gmail.com"]
  spec.homepage    = "http://BLA"
  spec.summary     = "Summary of SlimSmartListingRails."
  spec.description = "Description of SlimSmartListingRails."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.3"
  spec.add_dependency "slim-rails"
  spec.add_dependency "draper"
  spec.add_dependency 'best_in_place', '~> 3.1.1'
  spec.add_dependency "pundit"
  spec.add_dependency "jquery-rails"
  spec.add_dependency 'smart_listing', '~> 1.2.3'

  spec.add_development_dependency "sqlite3"
end
