require 'sip/concerns/models/persona'

module Cor1440Gen
  module Concerns
    module Models
      module Persona
        extend ActiveSupport::Concern

        included do
          include Sip::Concerns::Models::Persona


          has_many :asistencia, dependent: :delete_all,
            class_name: 'Cor1440Gen::Asistencia',
            foreign_key: 'persona_id'

          has_many :actividad, through: :asistencia, 
            class_name: 'Cor1440Gen::Actividad'

          has_and_belongs_to_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'persona_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_beneficiariopf'

          has_many :caracterizacionpersona,
            class_name: 'Cor1440Gen::Caracterizacionpersona', 
            foreign_key: 'persona_id'
          accepts_nested_attributes_for :caracterizacionpersona,
            reject_if: :all_blank

          def presenta_nombre
            ip = numerodocumento ? numerodocumento.to_s : ''
            if tdocumento
              ip = tdocumento.sigla.to_s + ":" + ip
            end
            r = nombres + " " + apellidos + 
              " (" + ip + ")"
            r
          end

          def importa(datosent, datossal, menserror, opciones = {})
            ndatosent = datosent.clone # Datos que falta analizar
            respuestafor = {} # Respuestas a formularios, llave id de formu.
            caracterizacion = {} # Caracterización, llave es id de formu.
            valorcampo = {} # Valores llave 1 es id formu. llave 2 es id campo

            datosent.keys.select {|ll| ll.to_s.include?('.')}.each do |ll|
              p = ll.to_s.split('.')
              if Mr519Gen::Formulario.where(nombreinterno: p[0]).count == 0
                menserror << "  No se encontró formulario con " +
                  "nombreinterno #{p[0]}."
              end
              f = Mr519Gen::Formulario.where(nombreinterno: p[0]).take
              # Imaginamos que por ahora no actualizamos sino sólo
              # creamos nuevos
              if !respuestafor[f.id]
                respuestafor[f.id] = Mr519Gen::Respuestafor.new(
                  formulario_id: f.id)
                caracterizacion[f.id] = Cor1440Gen::Caracterizacionpersona.new(
                  respuestafor: respuestafor[f.id]
                )
                valorcampo[f.id] = {}
              end

              case p[1]

              when 'ultimo_editor' 
                ue = ::Usuario.where(nusuario: datosent[ll])
                if ue.count == 0
                  menserror << "  No se ubicó editor #{datosent[ll]}."
                else
                  caracterizacion[f.id].ulteditor = ue.take
                end

              when 'fecha_ultimaedicion'
                fult = Sip::FormatoFechaHelper.reconoce_adivinando_locale(
                  datosent[ll])
                respuestafor[f.id].fechacambio = fult
              else
                if f.campo.where(nombreinterno: p[1]).count == 0
                  menserror << "  En formulario #{f.id} no se encontró campo con nombre interno #{p[1]}."
                  next
                end
                campo = f.campo.where(nombreinterno: p[1]).take

                if !valorcampo[f.id][campo.id]
                  valorcampo[f.id][campo.id] = Mr519Gen::Valorcampo.new(
                    respuestafor_id: respuestafor[f.id],
                    campo_id: campo.id)
                end
                op = []
                ope = nil
                if campo.tipo == Mr519Gen::ApplicationHelper::SELECCIONMULTIPLE
                  op = campo.opcioncs
                  if p.count > 2 # Solicitud tiene opcion
                    if op.where(valor: p[2]).count == 0
                      menserror << "  En formulario #{f.id}, el campo con nombre interno #{p[1]} no tiene una opción con valor #{p[2]}."
                    elsif op.where(valor: p[2]).count > 1
                      menserror << "  En formulario #{f.id}, el campo con nombre interno #{p[1]} tiene más de una opción con valor #{p[2]}."
                    end
                    ope = op.where(valor: p[2]).take
                    if datosent[ll].to_i != 1 && datosent[ll].to_i != 0
                      menserror << "  El valor #{datosent[ll]} para opcion " +
                        " #{p[1]} del formulario #{p[0]} (#{f.id}) debe ser " +
                        " 0 o 1."
                    elsif datosent[ll].to_i ==1
                      if !valorcampo[f.id][campo.id].valorjson
                        valorcampo[f.id][campo.id].valorjson = []
                      end
                      valorcampo[f.id][campo.id].valorjson << ope.id.to_s
                    end
                  else
                    # Ignoramos campos de selección multiple sin opción pues parece que en Kobo son solo informativos y podrían ser de interpretación ambigua.
                  end
                else # No es Seleccion multiple
                  valorcampo[f.id][campo.id].valor = datosent[ll]
                end
              end # case p[1]

              ndatosent.delete ll # Descartamos el que se analizó
            end
            datossal[:respuestafor] = respuestafor # Respuestas a formularios, llave id de formu.
            datossal[:caracterizacion] = caracterizacion # Caracterizaciones, llave es id de formu.
            datossal[:valorcampo] = valorcampo # Valores llave 1 es id formu. llave 2 es id campo

            return importa_sip(ndatosent, datossal, menserror, opciones)
          end

          def complementa_importa(ulteditor_id, datossal, menserror, opciones)
            puts "OJO complementa_importa ulteditor_id=#{ulteditor_id}"
            if !datossal[:respuestafor] ||
              !datossal[:caracterizacion] ||
              !datossal[:valorcampo] 
              menserror << "  Datos incompletos datossal en complementa_importa de #{self.class}."
              return
            end
            datossal[:respuestafor].each do |fid, r|
              r.fechaini = Date.today
              r.fechacambio = Date.today
              r.save
              if r.errors.messages && r.errors.messages.count > 0
                menserror << "  Error al salvar respuestafor de formulario #{fid}: #{r.errors.messages.to_s}."
              end

              # Si el formulario es caracterizacion de un solo
              # proyecto financiero agrega a la persona como
              # beneficiario de ese
              pf = Cor1440Gen::Caracterizacionpf.where(formulario_id: fid)
              if pf.count != 1
                puts "  Se enocntraron #{pf.count} convenios financieros que usan en caracterizaciones el formulario #{fid} (se esperaba 1 para ponerlo automaticamente, toca ponerlo manualmente)."
              else
                b = Cor1440Gen::Beneficiariopf.where(proyectofinanciero_id:
                                                 pf.take.id)
                if b.count == 0
                  self.proyectofinanciero_ids << pf.take.id
                end

              end
            end
            datossal[:caracterizacion].each do |fid, c|
              if datossal[:respuestafor][fid].id
                c.persona_id = self.id
                c.respuestafor_id = datossal[:respuestafor][fid].id
                if c.ulteditor_id.nil? 
                  if defined?(current_usuario)
                    c.ulteditor = current_usuario
                  else
                    c.ulteditor_id = ulteditor_id
                  end
                end
                c.save
                if c.errors.messages && c.errors.messages.count > 0
                  menserror << "  Error al salvar caracterizacion de formulario #{fid}: #{c.errors.messages.to_s}."
                end
              else
                menserror << " No pudo salvar caracterizacion formulario #{fid}."
              end
            end
            datossal[:valorcampo].each do |fid, cam|
              if datossal[:respuestafor][fid].id
                cam.each do |cid, v|
                  v.respuestafor_id = datossal[:respuestafor][fid].id
                  v.save
                  if v.errors.messages && v.errors.messages.count > 0
                    menserror << "  Error al salvar valor de campo #{v.campo_id} de formulario #{fid}: #{v.errors.messages.to_s}."
                  end
                end
              else
                menserror << " No pudo salvar valor(es) de formulario #{fid}."
              end
            end
          end


          scope :filtro_proyectofinanciero_ids, lambda { |p|
            joins(:proyectofinanciero).
              where('cor1440_gen_proyectofinanciero.id=?', p)
          }

        end # included
      end
    end
  end
end



