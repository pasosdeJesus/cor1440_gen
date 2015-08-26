class AgregaOficinaAUsuario < ActiveRecord::Migration
  def up
    if !column_exists? :usuario, :oficina_id
      add_column :usuario, :oficina_id, :integer, 
        references: 'sip_oficina'
      add_foreign_key :usuario, :sip_oficina, column: :oficina_id
    end
  end

  def down
    drop_column :usuario, :oficina_id
  end
end
