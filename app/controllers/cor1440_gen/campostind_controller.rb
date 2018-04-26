# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/campostind_controller"

module Cor1440Gen
  class CampostindController < Sip::ModelosController
    include Cor1440Gen::Concerns::Controllers::CampostindController
  end
end
