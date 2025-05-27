# frozen_string_literal: true

class AgregaIndiceUnicidadActividadPf < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      -- Quitamos duplicados
      DELETE FROM cor1440_gen_actividad_proyectofinanciero WHERE id NOT IN#{" "}
        (SELECT min FROM (SELECT actividad_id, proyectofinanciero_id, min(id)#{" "}
          FROM cor1440_gen_actividad_proyectofinanciero GROUP BY 1,2) AS s);
      CREATE UNIQUE INDEX cor1440_gen_actividad_proyectofinanciero_unico
        ON cor1440_gen_actividad_proyectofinanciero(actividad_id,#{" "}
          proyectofinanciero_id);
    SQL
  end

  def down
    execute(<<-SQL)
      DROP INDEX cor1440_gen_actividad_proyectofinanciero_unico;
    SQL
  end
end
