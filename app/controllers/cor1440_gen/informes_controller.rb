# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/informes_controller"

module Cor1440Gen
  class InformesController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::InformesController
  end
end
