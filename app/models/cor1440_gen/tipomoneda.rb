# frozen_string_literal: true

require "cor1440_gen/concerns/models/tipomoneda"

module Cor1440Gen
  # Tabla básicas Tipos de Moneda.
  class Tipomoneda < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Tipomoneda
  end
end
