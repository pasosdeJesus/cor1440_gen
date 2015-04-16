# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadareas_actividad'

module Cor1440Gen
  class ActividadareasActividad < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadareasActividad
  end
end
