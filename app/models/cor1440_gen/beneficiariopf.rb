# frozen_string_literal: true

require "cor1440_gen/concerns/models/beneficiariopf"

module Cor1440Gen
  # Relación n:n entre persona y convenio financiero.
  #
  # Un registro corresponde a un beneficiario de un convenio financiado.
  #
  # Ver detalles en descripción de cor1440_gen_caracterizacionpersona.
  class Beneficiariopf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Beneficiariopf
  end
end
