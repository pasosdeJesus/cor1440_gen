# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Actividad
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Modelo
          include Msip::Localizacion
          @current_usuario = -1
          attr_accessor :current_usuario

          attr_accessor :controlador

          belongs_to :oficina,
            class_name: "Msip::Oficina",
            validate: true,
            optional: true

          belongs_to :responsable,
            class_name: "::Usuario",
            foreign_key: "usuario_id",
            validate: true,
            optional: true

          has_many :actividad_actividadpf,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadActividadpf",
            foreign_key: "actividad_id"
          accepts_nested_attributes_for :actividad_actividadpf,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :actividadpf,
            through: :actividad_actividadpf,
            class_name: "Cor1440Gen::Actividadpf"

          has_and_belongs_to_many :actividadtipo,
            class_name: "Cor1440Gen::Actividadtipo",
            foreign_key: "actividad_id",
            association_foreign_key: "actividadtipo_id",
            join_table: "cor1440_gen_actividad_actividadtipo"

          has_and_belongs_to_many :orgsocial,
            class_name: "Msip::Orgsocial",
            foreign_key: "actividad_id",
            association_foreign_key: "orgsocial_id",
            join_table: "cor1440_gen_actividad_orgsocial"

          has_and_belongs_to_many :respuestafor,
            class_name: "Mr519Gen::Respuestafor",
            foreign_key: "actividad_id",
            dependent: :delete_all,
            association_foreign_key: "respuestafor_id",
            join_table: "cor1440_gen_actividad_respuestafor"
          accepts_nested_attributes_for :respuestafor,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :actividad_proyectofinanciero,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadProyectofinanciero",
            foreign_key: "actividad_id"
          accepts_nested_attributes_for :actividad_proyectofinanciero,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :proyectofinanciero,
            through: :actividad_proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero"

          has_and_belongs_to_many :usuario,
            class_name: "Usuario",
            foreign_key: "actividad_id",
            association_foreign_key: "usuario_id",
            join_table: "cor1440_gen_actividad_usuario"

          has_many :actividad_proyecto,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadProyecto",
            foreign_key: "actividad_id"

          has_many :actividadareas_actividad,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadareasActividad",
            foreign_key: "actividad_id"

          has_many :actividadareas,
            through: :actividadareas_actividad,
            class_name: "Cor1440Gen::Actividadarea"

          has_many :actividad_rangoedadac,
            foreign_key: "actividad_id",
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadRangoedadac"

          has_many :actividad_anexo,
            foreign_key: "actividad_id",
            validate: true,
            dependent: :destroy,
            class_name: "Cor1440Gen::ActividadAnexo",
            inverse_of: :actividad
          accepts_nested_attributes_for :actividad_anexo,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :asistencia,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Asistencia",
            foreign_key: "actividad_id",
            validate: true

          has_many :persona, through: :asistencia, class_name: "Msip::Persona"
          accepts_nested_attributes_for :persona, reject_if: :all_blank
          accepts_nested_attributes_for :asistencia,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :proyecto,
            through: :actividad_proyecto,
            class_name: "Cor1440Gen::Proyecto"

          has_many :rangoedadac,
            through: :actividad_rangoedadac,
            class_name: "Cor1440Gen::Rangoedadac"
          accepts_nested_attributes_for :rangoedadac, reject_if: :all_blank
          accepts_nested_attributes_for :actividad_rangoedadac,
            allow_destroy: true,
            reject_if: :all_blank

          has_many :anexo,
            through: :actividad_anexo,
            class_name: "Msip::Anexo"
          accepts_nested_attributes_for :anexo,
            reject_if: :all_blank

          campofecha_localizado :fecha

          validates_presence_of :oficina
          validates :fecha, presence: true, allow_blank: false
          validates :nombre,
            presence: true,
            allow_blank: false,
            length: { maximum: 500 }
          validates :objetivo, length: { maximum: 5000 }
          validates :resultado, length: { maximum: 5000 }
          validates :observaciones, length: { maximum: 5000 }

          validate :rol_usuario
          def rol_usuario
            if oficina_id && responsable && responsable.oficina_id &&
                responsable.oficina_id != oficina_id
              errors.add(:oficina, "Responsable y oficina deben coincidir")
            end
          end

          # Se quería validar duplicidad de actividadpf pero aquí
          # se ven sin duplicados, tocaría en el controlador

          validate :fecha_concuerda_corresponsables_habilitados
          def fecha_concuerda_corresponsables_habilitados
            if fecha && usuario && usuario.length > 0
              usuario.each do |u|
                if u.fechacreacion > fecha
                  errors.add(:usuario, "Corresponsable #{u.presenta_nombre} " +
                             " tiene fecha de creación posterior a la actividad")
                end
                next unless u.fechadeshabilitacion && u.fechadeshabilitacion < fecha

                errors.add(:usuario, "Corresponsable #{u.presenta_nombre} " +
                           " tiene fecha de deshabilitacion anterior " +
                           "a la actividad")
              end
            end
          end

          validate :fecha_concuerda_responsable_habilitado
          def fecha_concuerda_responsable_habilitado
            if fecha && responsable
              if responsable.fechacreacion > fecha
                errors.add(:responsable, "Responsable tiene " +
                           " fecha de creación posterior a la actividad")
              end
              if responsable.fechadeshabilitacion &&
                  responsable.fechadeshabilitacion < fecha
                errors.add(:responsable, "Responsable tiene " +
                           " fecha de deshabilitacion anterior a la actividad")
              end
            end
          end

          validate :identificacion_no_repetida
          def identificacion_no_repetida
            if asistencia
              asistencia.each do |a|
                next unless a.persona && !a.persona.numerodocumento.nil?

                pr = Msip::Persona
                  .where(tdocumento_id: a.persona.tdocumento_id)
                  .where(numerodocumento: a.persona.numerodocumento)
                  .where.not(id: a.persona.id)
                next unless pr.count > 0

                ids = pr.map(&:id)
                tdoc = ""
                if a.persona.tdocumento_id
                  tdoc = a.persona.tdocumento.sigla
                end
                errors.add(
                  :asistencia,
                  "Hay #{pr.count} beneficiarios (#{ids.join(", ")}) " \
                    "con tipo de documento '#{tdoc}' y " \
                    "número de documento '#{pr.take.numerodocumento}'",
                )
              end
            end
          end

          validate :asistentes_no_repetidos
          def asistentes_no_repetidos
            asistentes = []
            asistencia.map do |as|
              unless as.persona_id.nil?
                asistentes.push(as.persona_id)
              end
            end
            if asistentes.length != asistentes.uniq.length
              asrepetidos = []
              asrepetidos.push(asistentes.detect { |e| asistentes.count(e) > 1 })
              nombres = Msip::Persona.where(id: asrepetidos).map do |n|
                n.nombres + " " + n.apellidos
              end
              errors.add(:asistencia, "En listado de asistencia se encuentra " +
                         "repetido: " + nombres.join(", "))
            end
          end

          validate :asistentes_con_buena_edad
          def asistentes_con_buena_edad
            asistencia.each do |a|
              p = a.persona
              if p && p.anionac && (p.anionac > fecha.year ||
                  (p.mesnac && p.anionac == fecha.year &&
                   (p.mesnac > fecha.month ||
                    (p.dianac && p.mesnac == fecha.month &&
                     p.dianac > fecha.day)
                   )
                  ))
                errors.add(:asistentes, "El asistente con identificación " \
                  "#{p.tdocumento.sigla} #{p.numerodocumento} " \
                  "tiene fecha de nacimiento posterior " \
                  "a la de la actividad")
              elsif p && p.anionac && (fecha.year - p.anionac) > 119
                errors.add(:asistentes, "El asistente con identificación " \
                  "#{p.tdocumento.sigla} #{p.numerodocumento} " \
                  "tendría más de 120 años en la actividad")
              end
            end
          end

          # Usada por Msip::Modelo.copiar_y_guardar
          def excepciones_al_copiar_asociaciones
            [
              :actividad_anexo,
              :respuestafor,
            ]
          end

          # Usada por Msip::Modelo.copiar_y_guardar
          def copiar_especifico(registro)
            # De manera especial copiamos respuestafor asociado
            arfs = Cor1440Gen::ActividadRespuestafor.where(actividad_id: id)
            arfs.each do |arf|
              nr = arf.respuestafor.dup
              nr.save(validate: false)
              narf = arf.dup
              narf.respuestafor_id = nr.id
              narf.actividad_id = registro.id
              narf.save(validate: false)
              arf.respuestafor.valorcampo.each do |v|
                nv = v.dup
                nv.respuestafor_id = nr.id
                nv.save(validate: false)
              end
            end
          end # copiar_especifico

          def recalcula_poblacion
            ConteosHelper.recalcula_poblacion(self)
          end

          def presenta_nombre
            nombre
          end

          # Auxiliar que retorna listado de identificaciones de personas del
          # listado de asistentes que cumplan una condición
          def personas_asistentes_condicion
            ids = []
            asistencia.each do |a|
              if yield(a)
                ids << a.persona_id
              end
            end
            ids
          end

          def asistentes_ids
            idp = personas_asistentes_condicion { |_a| true }
            if idp.length > 0
              idp.uniq.sort.join(",")
            else
              ""
            end
          end

          def asistentes_nombres
            m = asistencia.map do |a|
              a.persona ? a.persona.presenta_nombre : ""
            end
            m.sort.join("; ")
          end

          def poblacion_cor1440_gen
            # En cuenta de poblacion no tiene en cuenta locales,
            # para coincidir con tipo de indicador que cuenta
            # usando tabla de población
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.mr ? r.mr : 0) +
                (r.fr ? r.fr : 0) +
                (r.s ? r.s : 0)
            end
          end

          def poblacion
            poblacion_cor1440_gen
          end

          def poblacion_hombres_l_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.ml ? r.ml : 0)
            end
          end

          def poblacion_hombres_r_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.mr ? r.mr : 0)
            end
          end

          def poblacion_mujeres_l_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.fl ? r.fl : 0)
            end
          end

          def poblacion_intersexuales_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.i ? r.i : 0)
            end
          end

          def poblacion_mujeres_r_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.fr ? r.fr : 0)
            end
          end

          def poblacion_sinsexo_solore
            actividad_rangoedadac.inject(0) do |memo, r|
              memo + (r.s ? r.s : 0)
            end
          end

          def poblacion_hombres_l_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.ml ? r.ml : 0)
            end
          end

          def poblacion_hombres_r_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.mr ? r.mr : 0)
            end
          end

          def poblacion_intersexuales_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.i ? r.i : 0)
            end
          end

          def poblacion_mujeres_l_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.fl ? r.fl : 0)
            end
          end

          def poblacion_mujeres_r_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.fr ? r.fr : 0)
            end
          end

          def poblacion_sinsexo_g_solore(num)
            actividad_rangoedadac.where(rangoedadac_id: num)
              .inject(0) do |memo, r|
              memo + (r.s ? r.s : 0)
            end
          end

          def presenta_cor1440_gen(atr)
            case atr.to_s
            when /anexo_[0-9]_desc/
              i = atr[6].to_i
              if anexo.count >= i
                anexo.order(:id)[i - 1].descripcion
              else
                ""
              end

            when Cor1440Gen::Actividad.human_attribute_name(
              :actividadareas,
            ).downcase.gsub(" ", "_")
              actividadareas.inject("") do |memo, r|
                memo +
                  (memo == "" ? r.presenta_nombre : "; " + r.presenta_nombre)
              end

            when Cor1440Gen::Actividad.human_attribute_name(
              :actividadpf,
            ).downcase.gsub(" ", "_")
              actividadpf.inject("") do |memo, r|
                memo +
                  (memo == "" ? r.presenta_nombre : "; " + r.presenta_nombre)
              end

            when "actualizacion"
              updated_at

            when "anexos_ids"
              anexo_ids.join(", ")

            when "campos_dinamicos"
              if !respuestafor || respuestafor.count == 0
                ""
              else
                respuestafor.inject("") do |memorf, rf|
                  seprf = memorf == "" ? "" : ". "
                  vc = rf.valorcampo.inject("") do |memo, v|
                    sep = memo == "" ? "" : ";"
                    if v.campo
                      memo + sep + v.campo.nombre + ": " + v.valor
                    else
                      memo
                    end
                  end
                  memorf + seprf + rf.formulario.nombreinterno +
                    "[" + vc + "]"
                end
              end
            when "creacion"
              created_at

            when "corresponsables"
              usuario.inject("") do |memo, r|
                memo +
                  (memo == "" ? r.presenta_nombre : "; " + r.presenta_nombre)
              end

            when "numero_anexos"
              anexo.count

            when Cor1440Gen::Actividad.human_attribute_name(
              :objetivopf,
            ).downcase.gsub(" ", "_")
              actividadpf.inject("") do |memo, a|
                sep = ""
                if memo != ""
                  sep = ";"
                end
                pn = ""
                if a.resultadopf && a.resultadopf.objetivopf
                  pn = a.resultadopf.objetivopf.presenta_nombre
                end
                memo + sep + pn
              end

            when "organizaciones_sociales"
              orgsocial.inject("") do |memo, a|
                nom = a.grupoper && a.grupoper.nombre ? a.grupoper.nombre : ""
                memo + (memo == "" ? "" : "; ") + nom
              end

            when "organizaciones_sociales_ids"
              orgsocial_ids.join(", ")

            when "poblacion_hombres_l"
              poblacion_hombres_l_solore

            when "poblacion_hombres_r"
              poblacion_hombres_r_solore

            when "poblacion_mujeres_l"
              poblacion_mujeres_l_solore

            when "poblacion_mujeres_r"
              poblacion_mujeres_r_solore

            when "poblacion_sinsexo"
              poblacion_sinsexo_solore

            when /poblacion_hombres_l_g[0-9]*/
              g = atr[21..-1].to_i
              poblacion_hombres_l_g_solore(g)

            when /poblacion_hombres_r_g[0-9]*/
              g = atr[21..-1].to_i
              poblacion_hombres_r_g_solore(g)

            when /poblacion_mujeres_l_g[0-9]*/
              g = atr[21..-1].to_i
              poblacion_mujeres_l_g_solore(g)

            when /poblacion_intersexuales_g[0-9]*/
              g = atr[25..-1].to_i
              poblacion_intersexuales_g_solore(g)

            when /poblacion_mujeres_r_g[0-9]*/
              g = atr[21..-1].to_i
              poblacion_mujeres_r_g_solore(g)

            when /poblacion_sinsexo_g[0-9]*/
              g = atr[19..-1].to_i
              poblacion_sinsexo_g_solore(g)

            when Cor1440Gen::Actividad.human_attribute_name(
              :proyectos,
            ).downcase.gsub(" ", "_")
              proyecto.inject("") do |memo, r|
                memo +
                  (memo == "" ? r.presenta_nombre : "; " + r.presenta_nombre)
              end

            when Cor1440Gen::Actividad.human_attribute_name(
              :proyectofinanciero,
            ).downcase.gsub(" ", "_")

              proyectofinanciero.inject("") do |memo, r|
                memo +
                  (memo == "" ? r.presenta_nombre : "; " + r.presenta_nombre)
              end

            when Cor1440Gen::Actividad.human_attribute_name(
              :proyectofinanciero,
            ).downcase.gsub(" ", "_") + "_id"
              proyectofinanciero.inject("") do |memo, r|
                memo + (memo == "" ? r.id.to_s : "; " + r.id.to_s)
              end
            when "responsable_nombre"
              responsable ? responsable.nombre : ""

            else
              presenta_gen(atr)
            end
          end

          def presenta_actividad(atr)
            presenta_cor1440_gen(atr)
          end

          def presenta(atr)
            presenta_cor1440_gen(atr)
          end

          scope :filtro_actividadpf, lambda { |ids|
            if ids != [""]
              where(
                "cor1440_gen_actividad.id IN (SELECT actividad_id FROM " +
                                    "cor1440_gen_actividad_actividadpf WHERE " +
                                    "actividadpf_id IN (?))",
                ids.map(&:to_i),
              )
            end
          }

          scope :filtro_actividadareas, lambda { |ida|
            where(
              "cor1440_gen_actividad.id IN (SELECT actividad_id FROM " +
                                "cor1440_gen_actividadareas_actividad WHERE " +
                                "actividadarea_id = ?)",
              ida,
            )
          }

          scope :filtro_fechaini, lambda { |f|
            where("fecha >= ?", f)
            # El control de fecha HTML estándar retorna la fecha
            # en formato yyyy-mm-dd siempre
          }

          scope :filtro_fechafin, lambda { |f|
            where("fecha <= ?", f)
          }

          scope :filtro_lugar, lambda { |l|
                                 where("unaccent(lugar) ILIKE '%' || unaccent(?) || '%'", l)
                               }

          scope :filtro_nombre, lambda { |n|
            where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", n)
          }

          scope :filtro_objetivo, lambda { |o|
            where("unaccent(objetivo) ILIKE '%' || unaccent(?) || '%'", o)
          }

          scope :filtro_observaciones, lambda { |o|
            where(
              "unaccent(observaciones) ILIKE '%' || unaccent(?) || '%'",
              o,
            )
          }

          scope :filtro_oficina, lambda { |oid|
            where(oficina_id: oid)
          }

          scope :filtro_proyectos, lambda { |idp|
            where(
              "cor1440_gen_actividad.id IN (SELECT actividad_id FROM " +
                                "cor1440_gen_actividad_proyecto WHERE " +
                                "proyecto_id = ?)",
              idp,
            )
          }

          scope :filtro_proyecto, lambda { |idp|
            where(
              "cor1440_gen_actividad.id IN (SELECT actividad_id FROM " +
                                "cor1440_gen_actividad_proyecto WHERE " +
                                "proyecto_id = ?)",
              idp,
            )
          }

          scope :filtro_proyectofinanciero, lambda { |ids|
            where(
              "cor1440_gen_actividad.id IN (SELECT actividad_id FROM " +
                                "cor1440_gen_actividad_proyectofinanciero WHERE " +
                                "proyectofinanciero_id IN (?))",
              ids.map(&:to_i),
            )
          }

          scope :filtro_responsable, lambda { |uid|
            where(usuario_id: uid)
          }

          scope :filtro_resultado, lambda { |r|
            where("unaccent(resultado) ILIKE '%' || unaccent(?) || '%'", r)
          }

          # En la medición de un indicador evalua un campo
          def evalua_campo(campo, menserr)
            case campo
            when "Asistentes"
              asistencia
            when "Organizaciones"
              orgsocial
            when "poblacion"
              poblacion
            else
              menserr = "Campo #{campo} no está en lista blanca de actividad. "
              puts menserr
              nil
            end
          end
        end
      end
    end
  end
end
