class OptimizaApf < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE INDEX ON public.cor1440_gen_actividad_proyectofinanciero 
        (actividad_id);
      CREATE INDEX ON public.cor1440_gen_actividad_proyectofinanciero 
        (proyectofinanciero_id);
      CREATE INDEX ON public.cor1440_gen_actividad
        (oficina_id);
    SQL
  end
  def down
    execute <<-SQL
      DROP INDEX public.cor1440_gen_actividad_oficina_id_idx;
      DROP INDEX public.cor1440_gen_actividad_proyectofinanciero_actividad_id_idx ;
      DROP INDEX public.cor1440_gen_actividad_proyectofinanci_proyectofinanciero_id_idx ;
    SQL
  end

end
