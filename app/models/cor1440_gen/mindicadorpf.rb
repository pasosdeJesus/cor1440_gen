# frozen_string_literal: true

require "cor1440_gen/concerns/models/mindicadorpf"

module Cor1440Gen
  class Mindicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Mindicadorpf
  end
end
