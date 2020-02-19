module SlimSmartListingRails
  module SlimSmartListingRailsHelper
    def editar_en_lugar(objeto, atributo, tipo = :input)
      if tipo == :checkbox
        best_in_place objeto, atributo, url: editar_en_lugar_url(objeto), as: tipo, collection: ["No", "Si"]
      elsif tipo == :date
        best_in_place objeto, atributo, url: editar_en_lugar_url(objeto), as: tipo, display_with: lambda { |v| dmy(v) }
        # best_in_place objeto, atributo, url: editar_en_lugar_url(objeto), as: tipo, display_with: lambda { |v| dmy(v) }, class: 'datefield'
      elsif tipo == :textarea
        funcion = lambda do |valor|
          return unless valor.present?
          valor.gsub!("\r\n", '<br>')
          valor.gsub!("\n", '<br>')
          valor.html_safe
        end
        best_in_place objeto, atributo, url: editar_en_lugar_url(objeto), as: tipo, display_with: funcion
      else
        best_in_place objeto, atributo, url: editar_en_lugar_url(objeto), as: tipo
      end
    end
  end
end
