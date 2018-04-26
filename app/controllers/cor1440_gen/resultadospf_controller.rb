# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/resultadospf_controller"

module Cor1440Gen
  class ResultadospfController < ApplicationController
    include Cor1440Gen::Concerns::Controllers::ResultadospfController
  end
end
