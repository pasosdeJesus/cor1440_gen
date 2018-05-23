# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Proyectofinanciero
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper
          campofecha_localizado :fechainicio
          campofecha_localizado :fechacierre

          belongs_to :responsable, class_name: 'Usuario',
            foreign_key: "responsable_id", validate: true

          has_many :proyecto_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::ProyectoProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :proyecto, through: :proyecto_proyectofinanciero,
            class_name: 'Cor1440Gen::Proyecto'

          has_many :actividad_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :actividad, through: :actividad_proyectofinanciero,
            class_name: 'Cor1440Gen::Actividad'

          has_many :financiador_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::FinanciadorProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :financiador, through: :financiador_proyectofinanciero,
            class_name: 'Cor1440Gen::Financiador'

          has_many :informe, dependent: :delete_all,
            class_name: 'Cor1440Gen::Informe',
            foreign_key: 'filtroproyectofinanciero'

          has_many :indicadorobjetivo, foreign_key: 'proyectofinanciero_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Indicadorpf'
          accepts_nested_attributes_for :indicadorobjetivo,
            allow_destroy: true, reject_if: :all_blank

          has_many :indicadorpf, foreign_key: 'proyectofinanciero_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Indicadorpf'
          accepts_nested_attributes_for :indicadorpf,
            allow_destroy: true, reject_if: :all_blank

          has_many :actividadpf, foreign_key: 'proyectofinanciero_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Actividadpf'
          accepts_nested_attributes_for :actividadpf,
            allow_destroy: true, reject_if: :all_blank

          has_many :resultadopf, foreign_key: 'proyectofinanciero_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Resultadopf'
          accepts_nested_attributes_for :resultadopf,
            allow_destroy: true, reject_if: :all_blank

          has_many :objetivopf, foreign_key: 'proyectofinanciero_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Objetivopf'
          accepts_nested_attributes_for :objetivopf,
            allow_destroy: true, reject_if: :all_blank


          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 1000 } 
          validates :compromisos, length: { maximum: 5000 }, 
            if: :hay_compromisos?
          def hay_compromisos?
            respond_to?(:compromisos)
          end

          validate :fechas_ordenadas
          def fechas_ordenadas
            if fechainicio && fechacierre && fechainicio > fechacierre
              errors.add(:fechacierre, 
                         "La fecha de cierre debe ser posterior a la de inicio")
            end
          end

          # Recibe un grupo de proyectosfinancieros y los filtra 
          # de acuerdo al control de acceso del usuario o a otros parametros
          # recibidos
          def filtra_acceso(current_usuario, pf, params = nil)
            return pf
          end

          scope :filtro_compromisos, lambda { |compromisos|
            where("unaccent(compromisos) ILIKE '%' || unaccent(?) || '%'", 
                  compromisos)
          }

          scope :filtro_fechainicioini, lambda { |f|
            where('fechainicio >= ?', f)
          }

          scope :filtro_fechainiciofin, lambda { |f|
            where('fechainicio <= ?', f)
          }

          scope :filtro_fechacierreini, lambda { |f|
            where('fechacierre >= ?',  f)
          }

          scope :filtro_fechacierrefin, lambda { |f|
            where('fechacierre <= ?', f)
          }

          scope :filtro_financiador_ids, lambda { |f|
            joins(:financiador_proyectofinanciero).
              where('cor1440_gen_financiador_proyectofinanciero.financiador_id=?', f)
          }

          scope :filtro_nombre, lambda { |nombre|
            where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", 
                  nombre)
          }

          scope :filtro_observaciones, lambda { |observaciones|
            where("unaccent(observaciones) ILIKE '%' || unaccent(?) || '%'", observaciones)
          }

          scope :filtro_proyecto_ids, lambda { |p|
            joins(:proyecto_proyectofinanciero).
              where('cor1440_gen_proyecto_proyectofinanciero.proyecto_id=?', p)
          }

          scope :filtro_responsable_id, lambda { |r|
            where(responsable_id: r)
          }


        end #included
        
        class_methods do

          def human_attribute_name(atr, poromision = "")
            if (atr.to_s == "{:proyecto_ids=>[]}")
              "Proyectos"
            elsif (atr.to_s == "{:financiador_ids=>[]}")
              "Financiadores"
            else
              super(atr)
            end
          end
        end # class_methods

      end
    end
  end
end
