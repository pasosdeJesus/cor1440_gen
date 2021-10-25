require_dependency 'cor1440_gen/concerns/controllers/formularios_controller'

module Mr519Gen
  class FormulariosController < Sip::ModelosController

    load_and_authorize_resource class: Mr519Gen::Formulario
    before_action :set_formulario, 
      only: [:show, :edit, :update, :destroy]
    include Cor1440Gen::Concerns::Controllers::FormulariosController    

  end
end
