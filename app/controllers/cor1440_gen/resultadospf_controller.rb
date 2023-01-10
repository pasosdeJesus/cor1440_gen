# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/resultadospf_controller"

module Cor1440Gen
  class ResultadospfController < ApplicationController
    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero
    include Cor1440Gen::Concerns::Controllers::ResultadospfController
  end
end
