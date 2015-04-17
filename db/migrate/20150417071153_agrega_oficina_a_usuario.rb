class AgregaOficinaAUsuario < ActiveRecord::Migration
  def change
    add_column :usuario, :oficina_id, :integer, 
      references: 'sip_oficina'
  end
end
