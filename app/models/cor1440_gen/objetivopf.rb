# frozen_string_literal: true

require "cor1440_gen/concerns/models/objetivopf"

module Cor1440Gen
  # Objetivo en el marco lógico de un convenio financiado.
  class Objetivopf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Objetivopf
  end
end
