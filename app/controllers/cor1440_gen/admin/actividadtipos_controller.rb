# encoding: UTF-8

require 'cor1440_gen/concerns/controllers/actividadtipos_controller'

module Cor1440Gen
  module Admin
    class ActividadtiposController < Sip::Admin::BasicasController
      include Cor1440Gen::Concerns::Controllers::ActividadtiposController
      load_and_authorize_resource class: Cor1440Gen::Actividadtipo
    end
  end
end
