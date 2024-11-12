# frozen_string_literal: true

require "cor1440_gen/concerns/models/proyectofinanciero"

module Cor1440Gen
  # Proyecto financiero
  class Proyectofinanciero < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Proyectofinanciero
  end
end
