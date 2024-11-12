# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_rangoedadac"

module Cor1440Gen
  # Relación n:n entre Actividad y Rango de edad en actividades
  class ActividadRangoedadac < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadRangoedadac
  end
end
