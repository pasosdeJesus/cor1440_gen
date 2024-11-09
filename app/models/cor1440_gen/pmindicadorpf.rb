# frozen_string_literal: true

require "cor1440_gen/concerns/models/pmindicadorpf"

module Cor1440Gen
  # Punto de medición de un indicador.   Se asocia a una especificación
  # cor1440_gen_mindicadorpf junto con un rango de fechas concretos sobre
  # el cual se hace la medición.
  class Pmindicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Pmindicadorpf
  end
end
