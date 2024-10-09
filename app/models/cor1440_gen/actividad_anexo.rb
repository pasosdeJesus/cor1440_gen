# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividad_anexo"

module Cor1440Gen
  # Relación n:n entre Actividad y Anexo
  class ActividadAnexo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadAnexo
  end
end
