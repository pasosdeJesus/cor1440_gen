# encoding: UTF-8

require 'cor1440_gen/concerns/models/actorsocial_efecto'

module Cor1440Gen
  class ActorsocialEfecto < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActorsocialEfecto
  end
end
