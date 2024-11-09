# frozen_string_literal: true

require "cor1440_gen/concerns/models/datointermedioti"

module Cor1440Gen
  # Especificación de un dato intermedio para el calculo de un indicador.
  # Por ejemplo si el indicador es más del 50% de beneficiario son mujeres
  # embarazadas, dos datos intermedios para calcular ese indicador son,
  # (1) total de beneficiarios, (2) beneficiarias que son mujeres embarazadas.
  class Datointermedioti < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Datointermedioti
  end
end
