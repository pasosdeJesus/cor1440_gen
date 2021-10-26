require_dependency "cor1440_gen/concerns/controllers/actividadespf_controller"

module Cor1440Gen
  class ActividadespfController < ApplicationController

    load_and_authorize_resource class: Cor1440Gen::Proyectofinanciero
    include Cor1440Gen::Concerns::Controllers::ActividadespfController
  end
end
