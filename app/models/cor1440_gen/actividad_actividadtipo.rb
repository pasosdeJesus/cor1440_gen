# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_actividadtipo"

module Cor1440Gen
  # Relación n:n entre Actividad y Tipo de Actividad
  class ActividadActividadtipo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadActividadtipo
  end
end
