# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/actividad_proyectosfinancieros_controller"

module Cor1440Gen
  class ActividadProyectosfinancierosController < ApplicationController
    load_and_authorize_resource class: ActividadProyectofinanciero

    include Cor1440Gen::Concerns::Controllers::ActividadProyectosfinancierosController
  end
end
