# encoding: UTF-8

require 'cor1440_gen/concerns/controllers/actoressociales_controller'

module Cor1440Gen
  module Admin
    class ActoressocialesController < Sip::Admin::BasicasController
      include Cor1440Gen::Concerns::Controllers::ActoressocialesController
      load_and_authorize_resource class: Cor1440Gen::Actorsocial
    end
  end
end
