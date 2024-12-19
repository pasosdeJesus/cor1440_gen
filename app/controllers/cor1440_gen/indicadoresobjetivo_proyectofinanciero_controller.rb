# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/indicadoresobjetivo_proyectofinanciero_controller"

module Cor1440Gen
  class IndicadoresobjetivoProyectofinancieroController < ApplicationController
    before_action :preparar_indicadorobjetivo_proyectofinanciero
    load_and_authorize_resource class: Cor1440Gen::Indicadorpf

    include Cor1440Gen::Concerns::Controllers::IndicadoresobjetivoProyectofinancieroController
  end
end
