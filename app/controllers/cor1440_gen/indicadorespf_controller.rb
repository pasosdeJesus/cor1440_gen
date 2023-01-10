# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/indicadorespf_controller"

module Cor1440Gen
  class IndicadorespfController < ApplicationController
    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero

    include Cor1440Gen::Concerns::Controllers::IndicadorespfController
  end
end
