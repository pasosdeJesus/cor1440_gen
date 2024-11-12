# frozen_string_literal: true

require "cor1440_gen/concerns/models/indicadorpf"

module Cor1440Gen
  # Indicador del marco lógico de un convenio financiado. 
  #
  # Puede ser tanto de un objetivo como de un resultado. 
  #
  # * Un indicador de objetivo tendrá objetivopf_id no nulo y 
  # resultadopf_id nulo.
  # * Un indicador de resultado tendrá objetivopf_id nulo y 
  # resultadopf_id no nulo.
  class Indicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Indicadorpf
  end
end
