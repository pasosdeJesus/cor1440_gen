# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/indicadorespf_controller"

module Cor1440Gen
  class IndicadorespfController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::IndicadorespfController
  end
end
