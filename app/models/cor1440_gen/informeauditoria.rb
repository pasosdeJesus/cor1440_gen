# frozen_string_literal: true

require "cor1440_gen/concerns/models/informeauditoria"

module Cor1440Gen
  class Informeauditoria < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Informeauditoria
  end
end
