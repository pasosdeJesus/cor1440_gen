# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividad_actorsocial'

module Cor1440Gen
  class ActividadActorsocial < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadActorsocial
  end
end
