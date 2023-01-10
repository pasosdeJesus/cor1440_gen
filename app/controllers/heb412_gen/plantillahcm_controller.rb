# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/plantillahcm_controller"

module Heb412Gen
  class PlantillahcmController < Msip::ModelosController
    before_action :set_plantillahcm, only: [
      :edit,
      :update,
      :destroy,
      :show,
      :impreso,
    ]
    load_and_authorize_resource class: Heb412Gen::Plantillahcm
    include Cor1440Gen::Concerns::Controllers::PlantillahcmController
  end
end
