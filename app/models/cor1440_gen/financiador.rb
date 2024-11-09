# frozen_string_literal: true

require "cor1440_gen/concerns/models/financiador"

module Cor1440Gen
  # Financiador de convenios financiados (e.g Diakonia)
  class Financiador < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Financiador
  end
end
