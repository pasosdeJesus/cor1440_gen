# encoding: UTF-8

require 'sip/concerns/controllers/personas_controller'

module Cor1440Gen
  module Concerns
    module Controllers
      module PersonasController

        extend ActiveSupport::Concern

        included do
          include Sip::Concerns::Controllers::PersonasController

          def atributos_index
            atributos_show
          end

          def atributos_show
            [ :id, 
              :nombres,
              :apellidos,
              :anionac,
              :mesnac,
              :dianac,
              :sexo,
              :pais,
              :departamento,
              :municipio,
              :clase,
              :nacionalde,
              :tdocumento,
              :numerodocumento
            ]
          end  

          def atributos_form
            a = atributos_show - [:id] + [:caracterizaciones]
            a[a.index(:clase)] = :id_clase
            a[a.index(:departamento)] = :id_departamento
            a[a.index(:municipio)] = :id_municipio
            a[a.index(:pais)] = :id_pais
            a[a.index(:tdocumento)] = :tdocumento_id
            return a
          end

          def asegura_camposdinamicos(persona)
            if persona.respond_to?(:proyectofinanciero)
              persona.proyectofinanciero.each do |pf|
                pf.caracterizacion.each do |ca|
                  cp = Cor1440Gen::Caracterizacionpersona.where(
                    proyectofinanciero_id: pf.id,
                    persona_id: persona.id)
                  if cp.count == 0
                    rf = Mr519Gen::Respuestafor.create(
                      formulario_id: ca.id,
                      fechaini: Date.today,
                      fechacambio: Date.today)
                    car = Cor1440Gen::Caracterizacionpersona.create(
                      proyectofinanciero_id: pf.id,
                      persona_id: persona.id,
                      respuestafor_id: rf.id,
                      ulteditor_id: current_usuario.id
                    )
                  elsif cp.count > 1
                    flash.now[:notice] = "Hay #{cp.count} caracterizaciones repetidas de esta persona y el proyecto #{pf.id}  (#{pf.nombre})"
                    car= cp.take
                  else
                    car = cp.take
                  end
                  Mr519Gen::ApplicationHelper::asegura_camposdinamicos(car)
                end
              end
            end
          end

          def edit
            @registro = clase.constantize.find(params[:id])
            if cannot? :edit, clase.constantize
              authorize! :update, @registro
            end
            asegura_camposdinamicos(@registro)
            render layout: 'application'
          end


          # API
        
          def datos
            @persona = Sip::Persona.find(params[:id_persona].to_i)
            authorize! :read, @persona
            respond_to do |format|
              oj = { 
                id: @persona.id,
                nombres: @persona.nombres,
                apellidos: @persona.apellidos,
                sexo: @persona.sexo,
                tdocumento: @persona.tdocumento ? @persona.tdocumento.sigla :
                 '',
                numerodocumento: @persona.numerodocumento,
                dianac: @persona.dianac,
                mesnac: @persona.mesnac,
                anionac: @persona.anionac 
              }
              format.json { render json: oj, status: :ok }
              format.html { render inilne: oj.to_s, status: :ok }
            end
          end
          private

          def lista_params_cor1440
            atributos_form + 
              [ "caracterizacionpersona_attributes" =>
                [ :id,
                  "respuestafor_attributes" => [
                    :id,
                    "valorcampo_attributes" => [
                      :valor,
                      :campo_id,
                      :id
                    ]
                ] ]
            ]
          end

          def lista_params
            lista_params_cor1440
          end

          def persona_params
            p = params.require(:persona).permit(lista_params)
            return p
          end


        end  # included

      end
    end
  end
end
