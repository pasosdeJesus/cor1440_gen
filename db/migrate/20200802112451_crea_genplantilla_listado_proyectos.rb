class CreaGenplantillaListadoProyectos < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL

      INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (40, 'plantillas/listado_de_proyectos.ods', 'Pasos de Jesús', 'Dominio público de acuerdo a legislación colombiana', 'Proyecto', 'Listado de proyectos', 5);

      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (401, 40, 'id', 'A');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (402, 40, 'nombre', 'B');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (403, 40, 'fechainicio_localizada', 'C');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (404, 40, 'fechacierre_localizada', 'D');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (405, 40, 'financiador', 'E');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (406, 40, 'monto', 'F');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (407, 40, 'responsable', 'G');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (408, 40, 'equipotrabajo', 'H');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (409, 40, 'compromisos', 'I');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (410, 40, 'observaciones', 'J');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (411, 40, 'fechacreacion_localizada', 'K');
      INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (412, 40, 'fechaactualizacion_localizada', 'L');

    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM public.heb412_gen_campoplantillahcm WHERE id>='401'
        AND id <='412';
      DELETE FROM public.heb412_gen_plantillahcm WHERE id=40;
    SQL
  end

end
