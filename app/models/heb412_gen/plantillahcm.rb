# frozen_string_literal: true

require "cor1440_gen/concerns/models/plantillahcm"
module Heb412Gen
  class Plantillahcm < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Plantillahcm
  end
end
