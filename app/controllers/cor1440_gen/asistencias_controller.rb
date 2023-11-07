# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/asistencias_controller"

module Cor1440Gen
  class AsistenciasController < Heb412Gen::ModelosController
    load_and_authorize_resource class: Cor1440Gen::Asistencia

    include Cor1440Gen::Concerns::Controllers::AsistenciasController
  end
end
