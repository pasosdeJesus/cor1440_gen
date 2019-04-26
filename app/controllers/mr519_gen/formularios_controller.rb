# encoding: UTF-8

require_dependency 'cor1440_gen/concerns/controllers/formularios_controller'

module Mr519Gen
  class FormulariosController < Sip::ModelosController
 
    include Cor1440Gen::Concerns::Controllers::FormulariosController    

  end
end
