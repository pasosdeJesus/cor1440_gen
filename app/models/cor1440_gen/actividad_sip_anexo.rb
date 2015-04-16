# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividad_sip_anexo'

module Cor1440Gen
  class ActividadSipAnexo < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadSipAnexo
  end
end
