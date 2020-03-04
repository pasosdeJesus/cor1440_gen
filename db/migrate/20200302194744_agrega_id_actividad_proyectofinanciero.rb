class AgregaIdActividadProyectofinanciero < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE SEQUENCE cor1440_gen_actividad_proyectofinanciero_id_seq
        START WITH 1
        INCREMENT BY 1
        NO MINVALUE
        NO MAXVALUE
        CACHE 1;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_proyectofinanciero
        ADD COLUMN id INTEGER NOT NULL
        UNIQUE DEFAULT(nextval('cor1440_gen_actividad_proyectofinanciero_id_seq'));
    SQL
        execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_proyectofinanciero ADD
        PRIMARY KEY (id);
    SQL
  end

  def down
    remove_column :cor1440_gen_actividad_proyectofinanciero, :id
  end
end
