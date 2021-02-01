class TituloProyectofinanciero < ActiveRecord::Migration[6.0]
  def up
    add_column :cor1440_gen_proyectofinanciero, :titulo, :string, limit: 1000
    execute <<-SQL
      UPDATE cor1440_gen_proyectofinanciero SET titulo=nombre;
    SQL
  end
  def down
    remove_column :cor1440_gen_proyectofinanciero, :titulo
  end
end
