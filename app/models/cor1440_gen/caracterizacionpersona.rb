# frozen_string_literal: true

require "cor1440_gen/concerns/models/caracterizacionpersona"

module Cor1440Gen
  # Caracterización de una persona (obsoleto)
  class Caracterizacionpersona < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Caracterizacionpersona
  end
end
