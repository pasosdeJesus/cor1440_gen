# frozen_string_literal: true

require "cor1440_gen/concerns/models/tipoindicador"

module Cor1440Gen
  # Tabla básica Tipos de Indicador
  class Tipoindicador < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Tipoindicador
  end
end
