# frozen_string_literal: true

module Cor1440Gen
  # Relación n:n entre Actividad y Área de actividad
  class ActividadProyecto < ActiveRecord::Base
    belongs_to :actividad,
      class_name: "Cor1440Gen::Actividad",
      optional: false
    belongs_to :proyecto,
      class_name: "Cor1440Gen::Proyecto",
      optional: false
  end
end
