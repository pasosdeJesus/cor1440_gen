# frozen_string_literal: true

require "cor1440_gen/concerns/models/actividadpf"

module Cor1440Gen
  class Actividadpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadpf
  end
end
