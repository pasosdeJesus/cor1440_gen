# encoding: UTF-8

require 'cor1440_gen/concerns/models/actividadpf_mindicadorpf'

module Cor1440Gen
  class ActividadpfMindicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::ActividadpfMindicadorpf
  end
end
