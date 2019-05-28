# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadtipo'

module Cor1440Gen
  class Actividadtipo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actividadtipo
  end
end
