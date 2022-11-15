class OptimizaNuevosBen < ActiveRecord::Migration[7.0]

  include Sip::SqlHelper

  def elimina_pares_duplicados(tabla, campo1, campo2)
    prep = execute <<-SQL
      SELECT #{campo1}, #{campo2} FROM (
        SELECT #{campo1}, #{campo2}, COUNT(*)
        FROM #{tabla}
        WHERE (#{campo1}, #{campo2}) IN
          (SELECT #{campo1}, #{campo2}
           FROM #{tabla})
        GROUP BY 1,2 ORDER BY 3 DESC) AS sub WHERE count>1;
    SQL
    pares = prep.map {|p| [p[campo1], p[campo2]]}
    execute <<-SQL
      DELETE FROM #{tabla}
      WHERE (#{campo1}, #{campo2}) IN
      (SELECT #{campo1}, #{campo2} FROM (
         SELECT #{campo1}, #{campo2}, COUNT(*)
         FROM #{tabla}
         WHERE (#{campo1}, #{campo2}) IN
           (SELECT #{campo1}, #{campo2}
            FROM #{tabla})
         GROUP BY 1,2 ORDER BY 3 DESC) AS sub WHERE count>1
       );
    SQL
  end
 
  def up
    if existe_restricción_pg?('sivel2_gen_actividad_pkey')
      execute <<-SQL
        ALTER TABLE cor1440_gen_actividad RENAME CONSTRAINT sivel2_gen_actividad_pkey TO cor1440_gen_actividad_pkey;
      SQL
    elsif existe_restricción_pg?('actividad_pkey')
      execute <<-SQL
        ALTER TABLE cor1440_gen_actividad RENAME CONSTRAINT actividad_pkey TO cor1440_gen_actividad_pkey;
      SQL
    end

    elimina_pares_duplicados('cor1440_gen_actividad_actividadpf', 'actividad_id', 'actividadpf_id')
    execute <<-SQL
      CREATE UNIQUE INDEX cor1440_gen_actividad_id_actividadpf_id_idx
        ON cor1440_gen_actividad_actividadpf (actividad_id, actividadpf_id);
    SQL

    elimina_pares_duplicados('cor1440_gen_asistencia', 'actividad_id', 'persona_id')

    execute <<-SQL
      CREATE UNIQUE INDEX cor1440_gen_actividad_id_persona_id_idx
        ON cor1440_gen_asistencia (actividad_id, persona_id);
    SQL

  end

  def down
    execute <<-SQL
      DROP INDEX IF EXISTS cor1440_gen_actividad_id_persona_id_idx;
      DROP INDEX IF EXISTS cor1440_gen_actividad_id_actividadpf_id_idx;
      ALTER TABLE cor1440_gen_actividad RENAME CONSTRAINT cor1440_gen_actividad_pkey TO actividad_pkey;
    SQL
  end
end
