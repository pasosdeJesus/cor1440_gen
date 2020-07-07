class CreaPfUsuario < ActiveRecord::Migration[6.0]
  def up
    if table_exists?(:proyectofinanciero_usuario)
      rename_table :proyectofinanciero_usuario,
        :cor1440_gen_proyectofinanciero_usuario
    else
      create_table :cor1440_gen_proyectofinanciero_usuario do |t|
        t.integer :proyectofinanciero_id, null: false
        t.integer :usuario_id
        t.timestamps null: false
      end
      add_foreign_key :cor1440_gen_proyectofinanciero_usuario, 
        :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
      add_foreign_key :cor1440_gen_proyectofinanciero_usuario, 
        :usuario, column: :usuario_id
    end
  end

  def down
    rename_table :cor1440_gen_proyectofinanciero_usuario,
      :proyectofinanciero_usuario
  end
end
