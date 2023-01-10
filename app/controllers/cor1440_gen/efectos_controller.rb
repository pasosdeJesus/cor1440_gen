# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/efectos_controller"

module Cor1440Gen
  class EfectosController < Heb412Gen::ModelosController
    before_action :set_efecto,
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Cor1440Gen::Efecto

    include Cor1440Gen::Concerns::Controllers::EfectosController
  end
end
