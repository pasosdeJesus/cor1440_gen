# frozen_string_literal: true

require "cor1440_gen/concerns/models/anexo_efecto"

module Cor1440Gen
  # Relación n:n entre Anexo y Efecto
  class AnexoEfecto < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::AnexoEfecto
  end
end
