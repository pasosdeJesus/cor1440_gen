# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Proyectofinanciero
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::FormatoFechaHelper

          campofecha_localizado :fechainicio
          campofecha_localizado :fechacierre
          campofecha_localizado :fechaaprobacion
          campofecha_localizado :fechaformulacion
          campofecha_localizado :fechaliquidacion

          flotante_localizado :aportepropioej
          flotante_localizado :aporteotrosej
          flotante_localizado :montoej
          flotante_localizado :presupuestototalej
          flotante_localizado :saldoaejecutarp
          flotante_localizado :tasaej

          campofecha_mesanio :fechaformulacion

          attr_accessor :duracion

          attr_accessor :semestreformulacion
          attr_accessor :montoejp_localizado
          attr_accessor :aportepropioejp_localizado
          attr_accessor :aporteotrosejp_localizado
          attr_accessor :presupuestototalejp_localizado

          cattr_accessor :current_usuario

          belongs_to :tipomoneda,
            class_name: "Cor1440Gen::Tipomoneda",
            optional: true

          has_many :desembolso,
            class_name: "Cor1440Gen::Desembolso",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :desembolso,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :informeauditoria,
            class_name: "Cor1440Gen::Informeauditoria",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :informeauditoria,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :informefinanciero,
            class_name: "Cor1440Gen::Informefinanciero",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :informefinanciero,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :informenarrativo,
            class_name: "Cor1440Gen::Informenarrativo",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :informenarrativo,
            allow_destroy: true,
            reject_if: :all_blank

          belongs_to :responsable,
            class_name: "::Usuario",
            optional: true,
            validate: true

          belongs_to :sectorapc,
            class_name: "Cor1440Gen::Sectorapc",
            optional: true,
            validate: true

          has_and_belongs_to_many :actividad,
            association_foreign_key: "actividad_id",
            class_name: "Cor1440Gen::Actividad",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_actividad_proyectofinanciero"

          has_and_belongs_to_many :beneficiario,
            association_foreign_key: "persona_id",
            class_name: "Msip::Persona",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_beneficiariopf"

          has_and_belongs_to_many :caracterizacion,
            association_foreign_key: "formulario_id",
            class_name: "::Mr519Gen::Formulario",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_caracterizacionpf"

          has_and_belongs_to_many :financiador,
            association_foreign_key: "financiador_id",
            class_name: "Cor1440Gen::Financiador",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_financiador_proyectofinanciero"

          has_and_belongs_to_many :plantillahcm,
            association_foreign_key: "plantillahcm_id",
            class_name: "::Heb412Gen::Plantillahcm",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_plantillahcm_proyectofinanciero"

          has_and_belongs_to_many :proyecto,
            association_foreign_key: "proyecto_id",
            class_name: "Cor1440Gen::Proyecto",
            foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_proyecto_proyectofinanciero"

          has_many :actividadpf,
            class_name: "Cor1440Gen::Actividadpf",
            dependent: :destroy,
            foreign_key: "proyectofinanciero_id",
            validate: true

          accepts_nested_attributes_for :actividadpf,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :anexo_proyectofinanciero,
            class_name: "::Cor1440Gen::AnexoProyectofinanciero",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :anexo_proyectofinanciero,
            allow_destroy: true,
            reject_if: :all_blank
          has_many :anexo,
            class_name: "::Msip::Anexo",
            through: :anexo_proyectofinanciero
          accepts_nested_attributes_for :anexo, reject_if: :all_blank

          has_many :indicadorobjetivo,
            class_name: "Cor1440Gen::Indicadorpf",
            dependent: :destroy,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :indicadorobjetivo,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :indicadorpf,
            class_name: "Cor1440Gen::Indicadorpf",
            dependent: :destroy,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :indicadorpf,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :informe,
            class_name: "Cor1440Gen::Informe",
            dependent: :delete_all,
            foreign_key: "filtroproyectofinanciero"

          has_many :mindicadorpf,
            class_name: "Cor1440Gen::Mindicadorpf",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id"

          has_many :objetivopf,
            class_name: "Cor1440Gen::Objetivopf",
            dependent: :destroy,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :objetivopf,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :proyectofinanciero_usuario,
            class_name: "Cor1440Gen::ProyectofinancieroUsuario",
            dependent: :delete_all,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :proyectofinanciero_usuario,
            allow_destroy: true 
            # se permiten en blanco para agregar POR CONTRATAR
          has_many :usuario,
            through: :proyectofinanciero_usuario,
            class_name: "::Usuario"

          has_many :resultadopf,
            class_name: "Cor1440Gen::Resultadopf",
            dependent: :destroy,
            foreign_key: "proyectofinanciero_id",
            validate: true
          accepts_nested_attributes_for :resultadopf,
            allow_destroy: true,
            reject_if: :all_blank

          validates :nombre,
            allow_blank: false,
            length: { maximum: 1000 },
            presence: true
          validates :titulo, length: { maximum: 1000 }

          validates :compromisos,
            length: { maximum: 5000 },
            if: :hay_compromisos?
          def hay_compromisos?
            respond_to?(:compromisos)
          end

          validates_associated :proyectofinanciero_usuario

          validate :fechas_ordenadas
          def fechas_ordenadas
            if fechainicio && fechacierre && fechainicio > fechacierre
              errors.add(
                :fechacierre,
                "La fecha de cierre debe ser posterior a la de inicio"
              )
            end
          end

          validate :fechainicio_posterior2000
          def fechainicio_posterior2000
            if fechainicio && fechainicio < Date.new(2000, 1, 1)
              errors.add(:fechainicio, "Fecha de inicio debe ser posterior a 1/Ene/2000")
            end
          end

          validate :dificultad_valida
          def dificultad_valida
            cv = Cor1440Gen::ApplicationHelper::DIFICULTAD.map { |r| r[1].to_s }
            unless cv.include?(dificultad)
              errors.add(:dificultad, "Dificultad no es válida")
            end
          end

          validate :estado_valido
          def estado_valido
            cv = Cor1440Gen::ApplicationHelper::ESTADO.map { |r| r[1].to_s }
            unless cv.include?(estado)
              errors.add(:estado, "Estado no es válido")
            end
          end

          def semestreformulacion
            if fechaformulacion
              if fechaformulacion.month <= 6
                "1"
              else
                "2"
              end
            end
          end

          def montoejp_localizado
            r = 0
            r = montoej * tasaej if montoej && tasaej
            r.a_decimal_localizado
          end

          def aportepropioejp_localizado
            r = 0
            r = aportepropioej * tasaej if aportepropioej && tasaej
            r.a_decimal_localizado
          end

          def aporteotrosejp_localizado
            r = 0
            r = aporteotrosej * tasaej if aporteotrosej && tasaej
            r.a_decimal_localizado
          end

          def presupuestototalej_localizado=(val)
            self[:presupuestototalej] = 0
            if montoej && aportepropioej && aporteotrosej
              self[:presupuestototalej] = montoej + aportepropioej +
                aporteotrosej
            end
          end

          def presupuestototalejp_localizado
            r = 0
            r = presupuestototalej * tasaej if presupuestototalej && tasaej
            r.a_decimal_localizado
          end

          def duracion
            if fechainicio && fechacierre
              Msip::FormatoFechaHelper.dif_meses_dias(fechainicio, fechacierre)
            else
              ""
            end
          end

          # Recibe un grupo de proyectosfinancieros y los filtra
          # de acuerdo al control de acceso del usuario o a otros parametros
          # recibidos
          def filtra_acceso(current_usuario, pf, params = nil)
            pf
          end

          scope :filtro_compromisos, lambda { |compromisos|
            where(
              "unaccent(cor1440_gen_proyectofinanciero.compromisos) "\
                "ILIKE '%' || unaccent(?) || '%'",
              compromisos.strip,
            )
          }

          scope :filtro_fechainicioini, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechainicio >= ?", f)
          }

          scope :filtro_fechainiciofin, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechainicio <= ?", f)
          }

          scope :filtro_fechacierreini, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechacierre >= ?", f)
          }

          scope :filtro_fechacierrefin, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechacierre <= ?", f)
          }

          scope :filtro_financiador_ids, lambda { |f|
            joins(:financiador)
              .where("cor1440_gen_financiador.id=?", f)
          }

          scope :filtro_nombre, lambda { |nombre|
            where(
              "unaccent(cor1440_gen_proyectofinanciero.nombre) "\
                "ILIKE '%' || unaccent(?) || '%'",
              nombre.strip,
            )
          }

          scope :filtro_observaciones, lambda { |observaciones|
            where(
              "unaccent(cor1440_gen_proyectofinanciero.observaciones) "\
                "ILIKE '%' || unaccent(?) || '%'",
              observaciones.strip,
            )
          }

          scope :filtro_proyecto_ids, lambda { |p|
            joins(:proyecto)
              .where("cor1440_gen_proyecto.id=?", p)
          }

          scope :filtro_responsable_id, lambda { |r|
            where("cor1440_gen_proyectofinanciero.responsable_id=?", r)
          }

          scope :filtro_titulo, lambda { |titulo|
            where(
              "unaccent(cor1440_gen_proyectofinanciero.titulo) ILIKE '%' "\
                "|| unaccent(?) || '%'",
              titulo.strip,
            )
          }

          scope :filtro_fechaformulacionini, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechaformulacion >= ?", f)
          }

          scope :filtro_fechaformulacionfin, lambda { |f|
            where("cor1440_gen_proyectofinanciero.fechaformulacion <= ?", f)
          }

          def presenta(atr)
            ## 4 Primeros Indicadores de objetivo
            cindob = /indicadorobj(.*)$/.match(atr.to_s)
            if cindob
              indobs = indicadorobjetivo.where(resultadopf_id: nil).order(:id)
              numero = cindob[1].split("_")[0]
              campo = cindob[1].split("_")[1]
              if indobs.count >= numero.to_i
                indicadorob = indobs[numero.to_i - 1]
                if indicadorob
                  case campo
                  when "refobj"
                    return indicadorob.objetivopf ? indicadorob.objetivopf.numero : ""
                  when "codigo"
                    return indicadorob.numero ? indicadorob.numero : ""
                  when "nombre"
                    return indicadorob.indicador ? indicadorob.indicador : ""
                  when "tipo"
                    return indicadorob.tipoindicador ? indicadorob.tipoindicador.nombre : ""
                  end
                end
              else
                return ""
              end
            end
            ## 4 Primeros Resultados
            cres = /resultado(.*)$/.match(atr.to_s)
            if cres
              resultados = resultadopf.order(:id)
              numero = cres[1].split("_")[0]
              campo = cres[1].split("_")[1]
              if resultados.count >= numero.to_i
                resultado = resultados[numero.to_i - 1]
                if resultado
                  case campo
                  when "refobj"
                    return resultado.objetivopf ? resultado.objetivopf.numero : ""
                  when "codigo"
                    return resultado.numero ? resultado.numero : ""
                  when "resultado"
                    return resultado.resultado ? resultado.resultado : ""
                  end
                end
              else
                return ""
              end
            end
            ## 6 Primeros indicadores de resultados
            cinres = /indicadorres(.*)$/.match(atr.to_s)
            if cinres
              indiresultados = indicadorpf.where(objetivopf_id: nil).order(:id)
              numero = cinres[1].split("_")[0]
              campo = cinres[1].split("_")[1]
              if indiresultados.count >= numero.to_i
                indicador = indiresultados[numero.to_i - 1]
                if indicador
                  case campo
                  when "refres"
                    ref = indicador.resultadopf
                    return ref ? ref.numero + ref.objetivopf.numero : ""
                  when "codigo"
                    return indicador.numero ? indicador.numero : ""
                  when "tipo"
                    return indicador.tipoindicador ? indicador.tipoindicador.nombre : ""
                  when "indicador"
                    return indicador.indicador ? indicador.indicador : ""
                  end
                end
              else
                return ""
              end
            end
            ## 8 Primeras Actividades
            cact = /actividadpf(.*)$/.match(atr.to_s)
            if cact
              actividades = actividadpf.order(:id)
              numero = cact[1].split("_")[0]
              campo = cact[1].split("_")[1]
              if actividades.count >= numero.to_i
                actividad = actividades[numero.to_i - 1]
                if actividad
                  case campo
                  when "refresultado"
                    ref = actividad.resultadopf
                    return ref && ref.numero && ref.objetivopf && 
                      ref.objetivopf.numero ? 
                      ref.numero + ref.objetivopf.numero : ""
                  when "codigo"
                    return actividad.nombrecorto ? actividad.nombrecorto : ""
                  when "tipo"
                    return actividad.actividadtipo ? actividad.actividadtipo.nombre : ""
                  when "actividad"
                    return actividad.titulo ? actividad.titulo : ""
                  when "descripcion"
                    return actividad.descripcion ? actividad.descripcion : ""
                  when "indicadoresgifmm"
                    return actividad.indicadorgifmm ? actividad.indicadorgifmm.nombre : ""
                  end
                end
              else
                return ""
              end
            end
            # Exporta Campos básicos de Convenios Financiados
            case atr.to_s
            when "nombres"
              nombre
            when "financiador"
              financiador ? financiador.pluck(:nombre).join(",") : ""
            when "area"
              proyecto ? proyecto.pluck(:nombre).join(",") : ""
            when "responsable"
              responsable ? responsable.nusuario : ""
            when "equipotrabajo"
              proyectofinanciero_usuario.map do |pu|
                pu.usuario ? pu.usuario.nusuario : "Por contratar"
              end.join("; ")
            when "objetivos"
              objetivopf ? objetivopf.pluck(:numero, :objetivo).map { |e| e.join(": ") }.join(". ") : ""
            when "obj1_texto"
              objetivopf.order(:id)[0] ? objetivopf.order(:id)[0].objetivo : ""
            when "obj1_cod"
              objetivopf.order(:id)[0] ? objetivopf.order(:id)[0].numero : ""
            when "obj2_texto"
              objetivopf.order(:id)[1] ? objetivopf.order(:id)[1].objetivo : ""
            when "obj2_cod"
              objetivopf.order(:id)[1] ? objetivopf.order(:id)[1].numero : ""
            when "indicadores_obj"
              inds = indicadorpf.where(resultadopf_id: nil).pluck(
                :numero,
                :indicador,
                :tipoindicador_id,
                :objetivopf_id,
              )
              indicadores = inds.map do |indi|
                (indi[3] ? Cor1440Gen::Objetivopf.find(indi[3]).numero : "") + ":" + (indi[0] ? indi[0] : "") + ": " + (indi[1] ? indi[1] : "") + ", " + (indi[2] ? Cor1440Gen::Tipoindicador.find(indi[2]).nombre : "")
              end.join(". ")
              indicadorobjetivo ? indicadores : ""
            when "indicadoresres"
              indres = indicadorpf.where(objetivopf: nil).order(:id).pluck(
                :resultadopf_id,
                :numero,
                :indicador,
                :tipoindicador_id,
              )
              indicadores = indres.map do |indi|
                (indi[0] ? (Cor1440Gen::Resultadopf.find(indi[0]).objetivopf.numero + ":" + Cor1440Gen::Resultadopf.find(indi[0]).numero) : "") + ". " + (indi[1] ? indi[1] : "") + ": " + (indi[2] ? indi[2] : "") + ", " + (indi[3] ? Cor1440Gen::Tipoindicador.find(indi[3]).nombre : "")
              end.join(". ")
              indicadorpf.where(objetivopf: nil) ? indicadores : ""
            when "resultados"
              ress = resultadopf.pluck(:numero, :objetivopf_id, :resultado)
              resultados = ress.map do |res|
                (res[0] ? res[0] : "") + ": " + (res[1] ? Cor1440Gen::Objetivopf.find(res[1]).numero : "") + ", " + (res[2] ? res[2] : "")
              end.join(". ")
              resultadopf ? resultados : ""
            when "actividadespf"
              acts = actividadpf.order(:id).pluck(
                :resultadopf_id,
                :nombrecorto,
                :actividadtipo_id,
                :titulo,
                :descripcion,
                :indicadorgifmm_id,
              )
              actividades = acts.map do |act|
                rpf = act[0] ? Cor1440Gen::Resultadopf.find(act[0]) : nil
                res = rpf && rpf.objetivopf && rpf.objetivopf.numero ? 
                  rpf.objetivopf.numero : ""
                res += rpf && rpf.numero ? 
                  rpf.numero : ""
                res += ": " 
                res += act[1] ? act[1] : ""
                res += ", " 
                res += act[2] ? 
                  Cor1440Gen::Actividadtipo.find(act[2]).nombre : ""
                res += ", "
                res += act[3] ? act[3] : ""
                res += ", "
                res += act[4] ? act[4] : ""
                res += ", "
                res += act[5] ? Indicadorgifmm.find(act[5]).nombre : ""
                res
              end.join(". ")
            else
              presenta_gen(atr)
            end
          end

          # Id del proyecto con actividades comunes vigente
          # nil significa que no hay.
          def self.actividades_comunes_id
            nil
          end

          # Id de un proyecto que deba agregarse siempre a toda actividad
          # nil significa que no hay.
          def self.en_toda_actividad_id
            nil
          end
        end # included

        class_methods do
          def human_attribute_name(atr, poromision = "")
            # if (atr.to_s == "{:proyecto_ids=>[]}")
            #  "Proyectos"
            # elsif (atr.to_s == "{:financiador_ids=>[]}")
            #  "Financiadores"
            # else
            super(atr)
            # end
          end
        end # class_methods
      end
    end
  end
end
