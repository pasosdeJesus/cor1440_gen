# encoding: UTF-8

require 'cor1440_gen/concerns/models/actorsocial'

module Sip
  class Actorsocial < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Actorsocial
  end
end
