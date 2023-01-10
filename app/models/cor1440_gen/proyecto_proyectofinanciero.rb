# frozen_string_literal: true

module Cor1440Gen
  class ProyectoProyectofinanciero < ActiveRecord::Base
    belongs_to :proyecto,
      class_name: "Cor1440Gen::Proyecto",
      optional: false
    belongs_to :proyectofinanciero,
      class_name: "Cor1440Gen::Proyectofinanciero",
      optional: false
  end
end
