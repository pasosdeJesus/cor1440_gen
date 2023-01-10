# frozen_string_literal: true

require "cor1440_gen/concerns/models/informefinanciero"

module Cor1440Gen
  class Informefinanciero < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Informefinanciero
  end
end
