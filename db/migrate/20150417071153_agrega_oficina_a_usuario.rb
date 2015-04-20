class AgregaOficinaAUsuario < ActiveRecord::Migration
  def change
    add_column :usuario, :oficina_id, :integer, 
      references: 'sip_oficina'
    add_foreign_key :usuario, :sip_oficina
  end
end
