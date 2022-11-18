class TablaDePoblacionSinRangosrepetidos < ActiveRecord::Migration[7.0]
  def up
    c = execute <<-SQL
    SELECT count(*) FROM cor1440_gen_actividad_rangoedadac
    WHERE (actividad_id, rangoedadac_id, id) NOT IN
      (SELECT actividad_id, rangoedadac_id, min(id)
        FROM cor1440_gen_actividad_rangoedadac GROUP BY 1,2
      )
    ;
    SQL
    puts  "Eliminando #{c[0]['count']} rangos de edad repetidos"
    execute <<-SQL
    DELETE FROM cor1440_gen_actividad_rangoedadac
      WHERE (actividad_id, rangoedadac_id, id) NOT IN
    (SELECT actividad_id, rangoedadac_id, min(id)
    FROM cor1440_gen_actividad_rangoedadac GROUP BY 1,2);
    SQL

    puts  "Agregando indice de unicidad"
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_rangoedadac ADD
        CONSTRAINT cor1440_gen_actividad_rangoedadac_unicos UNIQUE 
        (actividad_id, rangoedadac_id)
        ;
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_rangoedadac DROP
        CONSTRAINT cor1440_gen_actividad_rangoedadac_unicos
      ;
    SQL

  end
end
