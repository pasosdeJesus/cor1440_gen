# frozen_string_literal: true

require "cor1440_gen/concerns/models/tipomoneda"

module Cor1440Gen
  class Tipomoneda < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Tipomoneda
  end
end
