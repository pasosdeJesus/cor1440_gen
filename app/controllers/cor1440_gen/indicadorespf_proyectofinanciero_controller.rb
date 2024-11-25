# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/indicadorespf_proyectofinanciero_controller"

module Cor1440Gen
  class IndicadorespfProyectofinancieroController < ApplicationController
    before_action :preparar_indicadorpf_proyectofinanciero
    load_and_authorize_resource class: Cor1440Gen::Indicadorpf

    include Cor1440Gen::Concerns::Controllers::IndicadorespfProyectofinancieroController
  end
end
