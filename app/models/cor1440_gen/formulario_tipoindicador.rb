# frozen_string_literal: true

require "cor1440_gen/concerns/models/formulario_tipoindicador"

module Cor1440Gen
  class FormularioTipoindicador < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::FormularioTipoindicador
  end
end
