# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/personas_controller"

module Sip
  class PersonasController < Sip::ModelosController
    include Cor1440Gen::Concerns::Controllers::PersonasController
  end
end
