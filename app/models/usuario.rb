# encoding: UTF-8
class Usuario < ActiveRecord::Base
  @current_usuario = -1
  attr_accessor :current_usuario

  # Include default devise modules. Others available are:
  # :recoverable :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :lockable

	has_many :etiqueta_usuario, class_name: 'Cor440Gen::EtiquetaUsuario',
    dependent: :delete_all
	has_many :etiqueta, class_name: 'Sip::Etiqueta',
    through: :etiqueta_usuario

	belongs_to :oficina, class_name: 'Sip::Oficina',
    foreign_key: "oficina_id", validate: true

  #http://stackoverflow.com/questions/1200568/using-rails-how-can-i-set-my-primary-key-to-not-be-an-integer-typed-column
  self.primary_key=:id

  def email_required?
    false
  end
  validates_uniqueness_of    :nusuario,     :case_sensitive => false, :allow_blank => true
  validates_format_of :nusuario, :with  => /\A[a-zA-Z_0-9]+\z/, :allow_blank => true

  validates_presence_of :nusuario
  #validates_presence_of :password
  validates_presence_of :idioma
  validates_presence_of :rol
  validates_presence_of :email
  validates_presence_of :sign_in_count
  validates_presence_of :fechacreacion

  validates_presence_of   :encrypted_password, :on=>:create
  validates_confirmation_of   :encrypted_password, :on=>:create
  #validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  
  validate :rol_usuario
  def rol_usuario
    if regionsjr && (rol == Ability::ROLADMIN ||
      rol == Ability::ROLINV || 
      rol == Ability::ROLDIR)
      errors.add(:oficina, "Oficina debe estar en blanco para el rol elegido")
    end
    if !regionsjr && rol != Ability::ROLADMIN && rol != Ability::ROLINV && 
      rol != Ability::ROLDIR
      errors.add(:oficina, "El rol elegido debe tener oficina")
    end
#    if (etiqueta.count == 0 && rol == Ability::ROLINV) 
#      errors.add(:etiqueta, "El rol invitado debe tener etiquetas compartir")
#    end
    if (etiqueta.count != 0 && rol != Ability::ROLINV) 
      errors.add(:etiqueta, "El rol elegido no requiere etiquetas de compartir")
    end
    if (!current_usuario.nil? && current_usuario.rol == Ability::ROLCOOR)
        if (regionsjr.nil? || 
						regionsjr.id != current_usuario.regionsjr_id)
            errors.add(:regionsjr, "Solo puede editar usuarios de su oficina")
        end
    end
  end

end
