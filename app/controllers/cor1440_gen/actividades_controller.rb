# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < ApplicationController

    # Funcion por sobrecargar para filtrar por otros parámetros personalizados
    def self.filtramas(par, ac, current_usuario)
      return ac
    end

    include Cor1440Gen::Concerns::Controllers::ActividadesController
  end
end
