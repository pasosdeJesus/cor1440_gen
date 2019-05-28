# encoding: UTF-8

require 'cor1440_gen/concerns/models/campotind'

module Cor1440Gen
  class Campotind < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Campotind
  end
end
