# frozen_string_literal: true

require "cor1440_gen/concerns/controllers/personas_controller"

module Msip
  class PersonasController < Heb412Gen::ModelosController
    load_and_authorize_resource class: Msip::Persona
    include Cor1440Gen::Concerns::Controllers::PersonasController
  end
end
