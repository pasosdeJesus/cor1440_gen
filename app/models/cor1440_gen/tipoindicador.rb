# encoding: UTF-8

require 'cor1440_gen/concerns/models/tipoindicador'

module Cor1440Gen
  class Tipoindicador < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::Tipoindicador
  end
end
