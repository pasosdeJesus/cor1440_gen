# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadtipo"

module Cor1440Gen
  # Tabla básica Tipo de Actividad de Marco Lógico
  class Actividadtipo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadtipo
  end
end
