# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/tiposindicador_controller"

module Cor1440Gen
  module Admin
    class TiposindicadorController < Sip::ModelosController
      include Cor1440Gen::Concerns::Controllers::TiposindicadorController
    end
  end
end
