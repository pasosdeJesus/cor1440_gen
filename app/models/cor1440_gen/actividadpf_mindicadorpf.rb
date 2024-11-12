# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadpf_mindicadorpf"

module Cor1440Gen
  # Relación n:n entre una Actividad de Marco Lógico y la Medición de un
  # indicador 
  class ActividadpfMindicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadpfMindicadorpf
  end
end
