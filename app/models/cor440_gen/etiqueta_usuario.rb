# encoding: UTF-8
module Cor440Gen
  class EtiquetaUsuario < ActiveRecord::Base

    belongs_to :etiqueta, class_name: "Sip::Etiqueta",
      foreign_key: "etiqueta_id", validate: true
    belongs_to :usuario, class_name: "Usuario", 
      foreign_key: "usuario_id", validate: true
  end
end
