# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/objetivospf_controller"

module Cor1440Gen
  class ObjetivospfController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::ObjetivospfController
  end
end
