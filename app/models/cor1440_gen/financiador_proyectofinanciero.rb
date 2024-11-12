# frozen_string_literal: true

module Cor1440Gen
  # Relación n:n entre financiador y convenio financiado.
  # Un registro corresponde a un financiador de un convenio financiado.
  class FinanciadorProyectofinanciero < ActiveRecord::Base
    belongs_to :financiador,
      class_name: "Cor1440Gen::Financiador",
      optional: false
    belongs_to :proyectofinanciero,
      class_name: "Cor1440Gen::Proyectofinanciero",
      optional: false
  end
end
