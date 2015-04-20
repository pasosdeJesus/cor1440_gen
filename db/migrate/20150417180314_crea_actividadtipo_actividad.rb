class CreaActividadtipoActividad < ActiveRecord::Migration
  def up
    execute <<-SQL
        CREATE TABLE cor1440_gen_actividadtipo_actividad (
            actividadtipo_id    INTEGER REFERENCES cor1440_gen_actividadtipo(id),
            actividad_id    INTEGER REFERENCES cor1440_gen_actividad(id)
        );
    SQL
  end
  def down
    execute <<-SQL
        DROP TABLE cor1440_gen_actividadtipo_actividad;
    SQL
  end
    
end
