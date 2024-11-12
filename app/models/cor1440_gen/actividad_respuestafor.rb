# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_respuestafor"

module Cor1440Gen
  # Relación n:n entre Actividad y Respuestas de un Formulario
  class ActividadRespuestafor < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadRespuestafor
  end
end
