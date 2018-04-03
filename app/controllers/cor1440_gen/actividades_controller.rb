# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Sip::ModelosController

    include Cor1440Gen::Concerns::Controllers::ActividadesController
  end
end
