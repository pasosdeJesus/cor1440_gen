# frozen_string_literal: true

require "cor1440_gen/concerns/models/sectorapc"

module Cor1440Gen
  # Tabla básica Sectores APC
  class Sectorapc < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Sectorapc
  end
end
