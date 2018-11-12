class ReporteActividadHc < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      INSERT INTO heb412_gen_plantillahcr (id, ruta, fuente, licencia, 
        vista, nombremenu) VALUES (5, 'plantillas/reporte_una_actividad.ods',
        'Pasos de Jesús', 'Dominio Público', 'Actividad', 
        'Reporte de una actividad en hoja de cálculo');

      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (1, 5,
        'id', 'B', 3);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (2, 5,
        'fecha', 'G', 3);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (3, 5,
        'nombre', 'B', 4);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (4, 5,
        'oficina', 'B', 5);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (5, 5,
        'lugar', 'G', 5);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (6, 5,
        'áreas', 'B', 6);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (7, 5,
        'subáreas_de_actividad', 'G', 6);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (8, 5,
        'responsable', 'B', 7);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (9, 5,
        'corresponsables', 'G', 7);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (10, 5,
        'convenio_financiado', 'B', 9);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (11, 5,
        'actividad_de_convenio', 'B', 10);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (12, 5,
        'objetivo_convenio_financiero', 'G', 10);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (13, 5,
        'objetivo', 'B', 11);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (14, 5,
        'poblacion_mujeres_l_g1', 'B', 14);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (15, 5,
        'poblacion_hombres_l_g1', 'C', 14);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (16, 5,
        'poblacion_mujeres_r_g1', 'D', 14);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (17, 5,
        'poblacion_hombres_r_g1', 'E', 14);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (18, 5,
        'poblacion_mujeres_l_g2', 'B', 15);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (19, 5,
        'poblacion_hombres_l_g2', 'C', 15);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (20, 5,
        'poblacion_mujeres_r_g2', 'D', 15);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (21, 5,
        'poblacion_hombres_r_g2', 'E', 15);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (30, 5,
        'poblacion', 'B', 20);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (31, 5,
        'resultado', 'B', 23);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (35, 5,
        'poblacion_mujeres_l_g5', 'B', 18);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (36, 5,
        'poblacion_hombres_l_g5', 'C', 18);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (37, 5,
        'poblacion_mujeres_r_g5', 'D', 18);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (38, 5,
        'poblacion_hombres_r_g5', 'E', 18);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (39, 5,
        'poblacion_mujeres_l_g6', 'B', 19);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (40, 5,
        'poblacion_hombres_l_g6', 'C', 19);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (41, 5,
        'poblacion_mujeres_r_g6', 'D', 19);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (42, 5,
        'poblacion_hombres_r_g6', 'E', 19);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (33, 5,
        'creacion', 'B', 24);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (34, 5,
        'actualizacion', 'G', 24);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (25, 5,
        'poblacion_hombres_r_g3', 'E', 16);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (29, 5,
        'poblacion_hombres_r_g4', 'E', 17);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (24, 5,
        'poblacion_mujeres_r_g3', 'D', 16);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (28, 5,
        'poblacion_mujeres_r_g4', 'D', 17);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (23, 5,
        'poblacion_hombres_l_g3', 'C', 16);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (27, 5,
        'poblacion_hombres_l_g4', 'C', 17);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (22, 5,
        'poblacion_mujeres_l_g3', 'B', 16);
      INSERT INTO heb412_gen_campoplantillahcr (id, plantillahcr_id,
        nombrecampo, columna, fila) VALUES (26, 5,
        'poblacion_mujeres_l_g4', 'B', 17);
    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcr WHERE plantillahcr_id='5';
      DELETE FROM heb412_gen_plantillahcr WHERE id='5';
    SQL
  end
end
