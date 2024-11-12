# frozen_string_literal: true

require "cor1440_gen/concerns/models/resultadopf"

module Cor1440Gen
  # Resultado en el marco lógico de un convenio financiado.
  class Resultadopf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Resultadopf
  end
end
