# encoding: UTF-8

require_dependency "cor1440_gen/concerns/controllers/efectos_controller"

module Cor1440Gen
  class EfectosController < Heb412Gen::ModelosController

    include Cor1440Gen::Concerns::Controllers::EfectosController

  end
end
