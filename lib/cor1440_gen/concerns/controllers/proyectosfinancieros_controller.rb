# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ProyectosfinancierosController
        extend ActiveSupport::Concern
        #include Sip::ConsultasHelper

        included do
          before_action :set_proyectofinanciero, 
            only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero

          def clase 
            "Cor1440Gen::Proyectofinanciero"
          end

          def set_proyectofinanciero
            @basica = Proyectofinanciero.find(params[:id])
          end

          def create
            @basica = Proyectofinanciero.new(
              proyectofinanciero_params)
            @basica.fechacreacion =  
              DateTime.now.strftime('%Y-%m-%d') 

            if @basica.save
              redirect_to proyectofinanciero_path(@basica), 
                notice: 'Proyecto creado.'
            else
              render :new
            end
          end

          def update
            if @proyectofinanciero.update(proyectofinanciero_params)
              redirect_to proyectofinanciero_path(@proyectofinanciero), 
                notice: 'Proyecto actualizado.' 
            else
              render :edit
            end
          end

          def destroy
            @proyectofinanciero.destroy
            respond_to do |format|
              format.html { 
                redirect_to proyectosfinancieros_path, 
                notice: 'Proyecto eliminado' }
              format.json { head :no_content }
            end
          end

          def atributos_index
            [ "id", 
              "nombre" ] +
              [ :financiador_ids =>  [] ] +
              [ "fechainicio_localizada",
                "fechacierre_localizada",
                "responsable_id"
            ] +
            [ :proyecto_ids =>  [] ] +
            [ "compromisos", 
              "monto",
              "observaciones"
            ] 
          end

          # Genero del nombre (F - Femenino, M - Masculino)
          def genclase
            return 'M';
          end

          def proyectofinanciero_params
            params.require(:proyectofinanciero).permit(*atributos_form)
          end

        end # included

      end
    end
  end
end

