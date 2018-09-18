class ReporteActividadOdt < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO public.heb412_gen_plantilladoc (id, ruta, fuente, licencia, 
        vista, nombremenu) VALUES (5, 'plantillas/Reporte_actividad.odt', 
        'Pasos de Jesús', 'Dominio público', 'Actividad', 
        'Reporte de una Actividad en documento');
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM heb412_gen_plantilladoc WHERE id='5';
    SQL
  end
end
