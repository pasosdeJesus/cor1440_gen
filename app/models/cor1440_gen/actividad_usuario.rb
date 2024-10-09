# frozen_string_literal: true

module Cor1440Gen
  # Relación n:n entre actividad y usuario para especificar corresponsables
  class ActividadUsuario < ActiveRecord::Base
    belongs_to :actividad,
      class_name: "Cor1440Gen::Actividad",
      optional: false
    belongs_to :usuario,
      class_name: "Usuario",
      optional: false
  end
end
