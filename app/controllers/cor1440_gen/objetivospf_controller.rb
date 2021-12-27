require "cor1440_gen/concerns/controllers/objetivospf_controller"

module Cor1440Gen
  class ObjetivospfController < ApplicationController

    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero
    include Cor1440Gen::Concerns::Controllers::ObjetivospfController
  end
end
