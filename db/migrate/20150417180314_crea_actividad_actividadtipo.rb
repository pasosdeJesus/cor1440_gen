class CreaActividadActividadtipo < ActiveRecord::Migration
  def up
    execute <<-SQL
        CREATE TABLE cor1440_gen_actividad_actividadtipo (
            actividad_id    INTEGER REFERENCES cor1440_gen_actividad(id)
            actividadtipo_id    INTEGER REFERENCES cor1440_gen_actividadtipo(id),
        );
    SQL
  end
  def down
    execute <<-SQL
        DROP TABLE cor1440_gen_actividad_actividadtipo;
    SQL
  end
    
end
