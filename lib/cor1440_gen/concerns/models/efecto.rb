module Cor1440Gen
  module Concerns
    module Models
      module Efecto
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          belongs_to :indicadorpf, class_name: 'Cor1440Gen::Indicadorpf',
            foreign_key: "indicadorpf_id", validate: true, optional: false
          belongs_to :registradopor, class_name: '::Usuario',
            foreign_key: "registradopor_id", validate: true, optional: true

          has_and_belongs_to_many :respuestafor, 
            class_name: '::Mr519Gen::Respuestafor',
            foreign_key: 'efecto_id',
            association_foreign_key: 'respuestafor_id', 
            join_table: 'cor1440_gen_efecto_respuestafor'
          accepts_nested_attributes_for :respuestafor, 
            allow_destroy: true, reject_if: :all_blank

          has_many :efecto_orgsocial, class_name: 'Cor1440Gen::EfectoOrgsocial',
            dependent: :delete_all, foreign_key: 'efecto_id'
          has_many :orgsocial, class_name: 'Msip::Orgsocial',
            through: :efecto_orgsocial

          has_many :anexo_efecto, dependent: :delete_all,
            class_name: 'Cor1440Gen::AnexoEfecto',
            foreign_key: 'efecto_id', validate: true
          accepts_nested_attributes_for :anexo_efecto, 
            allow_destroy: true, reject_if: :all_blank
          has_many :anexo, :through => :anexo_efecto, 
            class_name: 'Msip::Anexo'
          accepts_nested_attributes_for :anexo,  reject_if: :all_blank

          campofecha_localizado :fecha

          validates :efecto_orgsocial, presence: true
          validates :fecha, presence: true
          validates :nombre, presence: true, length: { maximum: 500} 
          validates :descripcion, length: { maximum: 5000} 
          validates :indicadorpf_id, presence: true

          validate :tiene_anexo
          def tiene_anexo
            if !anexo_efecto.present?
              errors.add(:anexo_efecto, 
                         'Debe tener medios de verificación anexos')
            end
          end

          scope :filtro_orgsocial_id, lambda { |a|
            where('orgsocial_id = ?', a)
          }

          scope :filtro_fechaini, lambda { |f|
            where('fecha >= ?', f)
          }

          scope :filtro_fechafin, lambda { |f|
            where('fecha <= ?', f)
          }

          scope :filtro_indicadorpf_id, lambda { |i|
            where('indicadorpf_id = ?', i)
          }

          scope :filtro_nombre, lambda {|n|
            where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", n)
          } 

          scope :filtro_registradopor_id, lambda { |r|
            where('registradopor_id = ?', r)
          }

          def presenta(atr)
            case atr
            when 'indicadorpf_id'
              if indicadorpf_id
                indicadorpf.numero
              else
                ''
              end
            else
              presenta_gen(atr)
            end
          end 

        end # included

      end
    end
  end
end

