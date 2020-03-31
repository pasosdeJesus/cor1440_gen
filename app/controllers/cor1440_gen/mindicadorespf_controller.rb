# encoding: UTF-8

require_dependency 'cor1440_gen/concerns/controllers/mindicadorespf_controller'

module Cor1440Gen
  class MindicadorespfController < Sip::ModelosController

    include Cor1440Gen::Concerns::Controllers::MindicadorespfController

  end
end
