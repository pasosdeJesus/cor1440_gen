# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_actividadpf"

module Cor1440Gen
  # Relación n:n entre Actividad y Actividad de Marco Lógico
  class ActividadActividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadActividadpf
  end
end
