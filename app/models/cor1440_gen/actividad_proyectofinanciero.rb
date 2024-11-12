# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_proyectofinanciero"

module Cor1440Gen
  # Relación n:n entre Actividad y Convenio financiado
  class ActividadProyectofinanciero < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadProyectofinanciero
  end
end
