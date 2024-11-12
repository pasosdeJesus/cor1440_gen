# frozen_string_literal: true

require "cor1440_gen/concerns/models/anexo_proyectofinanciero"

module Cor1440Gen
  # Relación n:n entre Anexo y Proyecto financiero.
  class AnexoProyectofinanciero < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::AnexoProyectofinanciero
  end
end
