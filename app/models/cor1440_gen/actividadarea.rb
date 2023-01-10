# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadarea"

module Cor1440Gen
  class Actividadarea < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadarea
  end
end
