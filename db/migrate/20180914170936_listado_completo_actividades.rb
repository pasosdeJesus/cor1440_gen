class ListadoCompletoActividades < ActiveRecord::Migration[5.2]
  
  def up
    execute <<-SQL 

      INSERT INTO public.heb412_gen_plantillahcm (id, 
        ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (5, 
        'plantillas/listado_de_actividades.ods', 
        'Pasos de Jesús', 'Dominio Público', 'Actividad', 
        'Listado Completo de Actividades', 5);

      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (500, 5, 'id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (501, 5, 'nombre', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (502, 5, 'fecha', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (503, 5, 'lugar', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (504, 5, 'oficina', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (505, 5, 'convenio_financiado', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (506, 5, 'actividad_de_convenio', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (507, 5, 'áreas', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (508, 5, 'subáreas_de_actividad', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (509, 5, 'responsable', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (510, 5, 'corresponsables', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (511, 5, 'objetivo', 'L');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (512, 5, 'resultado', 'M');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (513, 5, 'poblacion', 'N');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (514, 5, 'observaciones', 'O');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (515, 5, 'creacion', 'P');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, 
        nombrecampo, columna) VALUES (516, 5, 'actualizacion', 'Q');
    SQL
  end

  def down
    execute <<-SQL 
      DELETE FROM heb412_gen_campoplantillahcm WHERE plantillahcm_id='5';
      DELETE FROM heb412_gen_plantillahcm WHERE id='5';
    SQL
  end

end
