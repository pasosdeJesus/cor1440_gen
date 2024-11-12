# frozen_string_literal: true

require "cor1440_gen/concerns/models/caracterizacionpf"

module Cor1440Gen
  # Relación n:n entre formulario (de caracterización) y convenio financiado.
  #
  # Un registro corresponde a un formulario de caracterización para un convenio
  # financiado.
  #
  # Ver detalles en descripción de cor1440_gen_caracterizacionpersona.
  class Caracterizacionpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Caracterizacionpf
  end
end
