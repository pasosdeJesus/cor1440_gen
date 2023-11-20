# frozen_string_literal: true

require "msip/concerns/controllers/personas_controller"

module Cor1440Gen
  module Concerns
    module Controllers
      module PersonasController
        extend ActiveSupport::Concern

        included do
          include Msip::Concerns::Controllers::PersonasController

          def atributos_show_cor1440_gen
            atributos_show_msip + [
              :proyectofinanciero_ids,
              :actividad_ids,
            ]
          end

          def atributos_show
            atributos_show_cor1440_gen
          end

          def atributos_index_cor1440_gen
            atributos_index_msip + [
              :proyectofinanciero_ids,
              :actividad_ids,
            ]
          end

          def atributos_index
            atributos_index_cor1440_gen
          end

          def atributos_form_cor1440_gen
            a = atributos_form_msip - [:actividad_ids] + [:caracterizaciones]
            a[a.index(:centropoblado)] = :centropoblado_id
            a[a.index(:departamento)] = :departamento_id
            a[a.index(:municipio)] = :municipio_id
            a[a.index(:pais)] = :pais_id
            if a.index(:tdocumento)
              a[a.index(:tdocumento)] = :tdocumento_id
            end
            a
          end

          def atributos_form
            atributos_form_cor1440_gen
          end

          def self.asegura_camposdinamicos(persona, current_usuario_id)
            if persona.respond_to?(:proyectofinanciero)
              persona.proyectofinanciero.each do |pf|
                pf.caracterizacion.each do |ca|
                  cp = Cor1440Gen::Caracterizacionpersona.where(
                    persona_id: persona.id,
                  ).where('respuestafor_id IN
                  (SELECT id FROM mr519_gen_respuestafor WHERE
                     formulario_id=?)',
                    ca.id)
                  if cp.count == 0
                    rf = Mr519Gen::Respuestafor.create(
                      formulario_id: ca.id,
                      fechaini: Date.today,
                      fechacambio: Date.today,
                    )
                    car = Cor1440Gen::Caracterizacionpersona.create(
                      persona_id: persona.id,
                      respuestafor_id: rf.id,
                      ulteditor_id: current_usuario_id,
                    )
                  elsif cp.count > 1
                    flash.now[:notice] =
"Hay #{cp.count} caracterizaciones repetidas de esta persona y el proyecto #{pf.id}  (#{pf.nombre})"
                    car = cp.take
                  else # cp.count == 1
                    car = cp.take
                  end
                  Mr519Gen::ApplicationHelper.asegura_camposdinamicos(
                    car, current_usuario_id
                  )
                end
              end
            end
          end

          def editar_intermedio(registro, usuario_actual_id)
            if params["proyectofinanciero_ids"]
              registro.proyectofinanciero_ids = if params["proyectofinanciero_ids"] == ["-1"] # Convención vacio
                # Si la llamada AJAC se hace con [] ese parametro no llega
                []
              else
                params["proyectofinanciero_ids"]
              end
            end
            self.class.asegura_camposdinamicos(registro, usuario_actual_id)
          end

          # Al acatualizar eliminamos caracterizacionespersona de
          # proyectos de los cuales la persona ya no sea beneficiario
          def actualizar_intermedio
            quedan = @registro.caracterizacionpersona.where(
              "respuestafor_id IN (SELECT id " +
              "FROM mr519_gen_respuestafor AS rf " +
              "JOIN cor1440_gen_caracterizacionpf AS cpf ON " +
              "rf.formulario_id=cpf.formulario_id JOIN " +
              "cor1440_gen_beneficiariopf AS bpf ON " +
              "bpf.proyectofinanciero_id=cpf.proyectofinanciero_id " +
              "WHERE bpf.persona_id=?)",
              @registro.id,
            ).pluck(:id)
            elim = @registro.caracterizacionpersona_ids - quedan
            if elim != []
              Cor1440Gen::Caracterizacionpersona.where(id: elim).delete_all
            end
            true
          end

          def vistas_manejadas
            ["Persona"]
          end

          def actualiza_especial(registro, paramf, paramsf)
            true
          end

          def self.valor_campo_compuesto(registro, campo)
            p = campo.split(".")
            if Mr519Gen::Formulario.where(nombreinterno: p[0]).count == 0
              return "No se encontró formulario con nombreinterno #{p[0]}"
            end

            f = Mr519Gen::Formulario.where(nombreinterno: p[0]).take

            car = Cor1440Gen::Caracterizacionpersona.where(
              persona_id: registro.id,
            ).where('respuestafor_id IN
              (SELECT id FROM mr519_gen_respuestafor
              WHERE formulario_id=?)',
              f.id)
            if car.count == 0
              return "" # No se encontró caracterización para persona #{registro.id} con formulario #{f.id}
            elsif car.count > 1
              return "Hay #{car.count} caracterizaciones para la persona #{registro.id} con formulario #{f.id}"
            end

            car = car.take

            if p[1] == "ultimo_editor"
              return car.ulteditor.nusuario
            end

            rf = car.respuestafor

            if p[1] == "fecha_ultimaedicion"
              return rf.fechacambio
            end

            if f.campo.where(nombreinterno: p[1]).count == 0
              return "En formulario #{f.id} no se encontró campo con nombre interno #{p[2]}"
            end

            campo = f.campo.where(nombreinterno: p[1]).take
            op = []
            ope = nil
            if campo.tipo == Mr519Gen::ApplicationHelper::SELECCIONMULTIPLE
              op = campo.opcioncs
              if p.count > 2 # Solicitud tiene opcion
                if op.where(valor: p[2]).count == 0
                  return "En formulario #{f.id}, el campo con nombre interno #{p[1]} no tiene una opción con valor #{p[2]}"
                elsif op.where(valor: p[2]).count > 1
                  return "En formulario #{f.id}, el campo con nombre interno #{p[1]} tiene más de una opción con valor #{p[2]}"
                end

                ope = op.where(valor: p[2]).take
              end
            end
            if rf.valorcampo.where(campo_id: campo.id).count == 0
              return "En respuesta a formularoi #{rf.id} no se encontró valor para el campo #{campo.id}"
            end

            vc = rf.valorcampo.where(campo_id: campo.id).take
            unless ope.nil?
              return vc.valorjson.include?(ope.id.to_s) ? 1 : 0
            end

            if campo.tipo == Mr519Gen::ApplicationHelper::SELECCIONMULTIPLE
              cop = vc.valorjson.select { |i| i != "" }.map do |idop|
                ope = Mr519Gen::Opcioncs.where(id: idop.to_i)
                if ope.count == 0
                  "No hay opcion con id #{idop}"
                else
                  ope.take.nombre
                end
              end
              return cop.join(". ")
            end

            vc.presenta_valor(false)
          end

          private

          def lista_params_cor1440
            atributos_form +
              ["caracterizacionpersona_attributes" =>
                [
                  :id,
                  "respuestafor_attributes" => [
                    :id,
                    "valorcampo_attributes" => [
                      :valor,
                      :campo_id,
                      :id,
                    ] + [valor_ids: []],
                  ],
                ]] + [
                  "proyectofinanciero_ids" => [],
                ]
          end

          def lista_params
            lista_params_cor1440
          end

          def persona_params
            p = params.require(:persona)
            p = p.permit(lista_params)
            p
          end
        end  # included

        class_methods do
        end
      end
    end
  end
end
