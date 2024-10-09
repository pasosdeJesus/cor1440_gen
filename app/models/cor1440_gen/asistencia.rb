# frozen_string_literal: true

require "cor1440_gen/concerns/models/asistencia"

module Cor1440Gen
  # Relación n:n entre Persona y Actividad. Modela asistencia de una persona
  # a una actividad.
  class Asistencia < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Asistencia
  end
end
