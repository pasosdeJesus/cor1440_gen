# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/tiposindicador_controller"

module Cor1440Gen
  module Admin
    class TiposindicadorController < Msip::ModelosController
      before_action :set_tipoindicador,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Tipoindicador

      include Cor1440Gen::Concerns::Controllers::TiposindicadorController
    end
  end
end
