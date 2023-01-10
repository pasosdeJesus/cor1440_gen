# frozen_string_literal: true

require "cor1440_gen/concerns/models/persona"
module Msip
  class Persona < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Persona
  end
end
