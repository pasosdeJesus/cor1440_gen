# frozen_string_literal: true

require "cor1440_gen/concerns/models/beneficiariopf"

module Cor1440Gen
  # Beneficiario de un proyecto financiero. Permite asociar un formulario
  # de caracterización para ampliar la información de la persona y permitir
  # sistematizar lo especifico que requiera el proyecto.
  class Beneficiariopf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Beneficiariopf
  end
end
