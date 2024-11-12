# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadpf"

module Cor1440Gen
  # Actividad de marco lógico, asociada a un resultado de un 
  # convenio financiado.
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf
  end
end
