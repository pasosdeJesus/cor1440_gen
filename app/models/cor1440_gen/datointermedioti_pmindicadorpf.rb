# frozen_string_literal: true

require "cor1440_gen/concerns/models/datointermedioti_pmindicadorpf"

module Cor1440Gen
  # Calculo concreto de un dato intermedio útil para el cálculo de un indicador
  # en un punto de medición (i.e rango de # tiempo) especifico.
  class DatointermediotiPmindicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::DatointermediotiPmindicadorpf
  end
end
