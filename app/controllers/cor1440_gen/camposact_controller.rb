# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/camposact_controller"

module Cor1440Gen
  class CamposactController < Sip::ModelosController
    include Cor1440Gen::Concerns::Controllers::CamposactController
  end
end
