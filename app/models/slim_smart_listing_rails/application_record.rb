module SlimSmartListingRails
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def to_s
      [:nombre, :name].each do |campo|
        if try(campo).present?
          return send(campo)
        end
      end
      super
    end
  end
end
