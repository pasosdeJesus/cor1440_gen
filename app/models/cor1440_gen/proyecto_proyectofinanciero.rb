# frozen_string_literal: true

module Cor1440Gen
  # Relación n:n entre área de actividad y convenio financiado
  class ProyectoProyectofinanciero < ActiveRecord::Base
    belongs_to :proyecto,
      class_name: "Cor1440Gen::Proyecto",
      optional: false
    belongs_to :proyectofinanciero,
      class_name: "Cor1440Gen::Proyectofinanciero",
      optional: false
  end
end
