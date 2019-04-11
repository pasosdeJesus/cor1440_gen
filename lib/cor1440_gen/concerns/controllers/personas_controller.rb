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


          def actualiza_especial(registro, paramf, paramsf)
            return true
          end


          def self.valor_campo_compuesto(registro, campo)
            p = campo.partition('.')
            if Mr519Gen::Formulario.where(nombreinterno: p[0]).count == 0
              return "No se encontró formulario con nombreinterno #{p[0]}"
            end
            f = Mr519Gen::Formulario.where(nombreinterno: p[0]).take
            if f.campo.where(nombreinterno: p[2]).count == 0
              return "En formulario #{f.id} no se encontró campo con nombre interno #{p[2]}"
            end
            c = f.campo.where(nombreinterno: p[2]).take
            rfs=Mr519Gen::Respuestafor.joins('JOIN cor1440_gen_caracterizacionpersona AS car ON car.respuestafor_id=mr519_gen_respuestafor.id').where(formulario_id: f.id).where('car.persona_id=?', registro.id) 
            if rfs.count == 0
              return "No hay caracterización"
            end
            if rfs.count > 1
              return "Hay varios proyectos con respuesta"
            end
            rf = rfs.take
            if rf.valorcampo.where(campo_id: c.id).count == 0
              return "En respuesta a formularoi #{rf.id} no se encontró valor para el campo #{c.id}"
            end

            vc = rf.valorcampo.where(campo_id: c.id).take
            #byebug
            vc.presenta_valor(false)
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
                     ] + [:valor_ids => []],
                ] ]
            ]
          end

          def lista_params
            lista_params_cor1440
          end

          def persona_params
            p = params.require(:persona)
            p= p.permit(lista_params)
            return p
          end


        end  # included

      end
    end
  end
end
