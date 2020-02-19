module SlimSmartListingRails
  class EditarEnLugarController < ::ApplicationController
    def editar_en_lugar
      key_modelo = params.keys[1]
      modelo = Kernel.const_get(key_modelo)
      objeto = modelo.find params[:id]
      authorize objeto
      object_params = request.parameters[key_modelo]
      objeto.update_attributes(object_params)
      respond_with_bip(objeto, param: key_modelo)
    rescue Pundit::NotAuthorizedError => e
      objeto.errors.add(:base, "no autorizado")
      respond_with_bip(objeto)
    rescue Pundit::Error => e
      Rollbar.error(e)
      logger.error(e.message)
      objeto.errors.add(:base, e.message)
      respond_with_bip(objeto)
    end
  end
end