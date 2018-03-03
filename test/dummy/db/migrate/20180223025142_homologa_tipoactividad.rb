# encoding: UTF-8
# Este debe estar en test/dummy y tener un remplazo con el mismo nombre
# en cada descendiente de cor1440_gen con datos anteriores a 23.Feb.2108

class HomologaTipoactividad < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_proyectofinanciero (id, nombre, observaciones, 
        fechainicio, fechacierre, fechacreacion, fechadeshabilitacion, 
        created_at, updated_at, compromisos, monto) 
        VALUES (1, 'TIPOS DE ACTIVIDAD ANTES 2018-1',
        'Es para homologar antiguo concepto de tipo de actividad',
        '2014-01-01', '2018-02-20', '2018-02-23', NULL,
        '2018-02-23', '2018-02-23', '', 0);

      INSERT INTO cor1440_gen_objetivopf (id, proyectofinanciero_id, 
        numero, objetivo) VALUES (1, 1, 
        'HAC', 'Homologar antiguo concepto de tipo de actividad');
      INSERT INTO cor1440_gen_resultadopf (id, proyectofinanciero_id, 
        objetivopf_id, numero, resultado) VALUES (1, 1, 
        1, 'TIPOSAC', 'Tipos de actividad');
     -- Podría pensars un indicador para medir frecuencia de tipos de actividad

      INSERT INTO cor1440_gen_actividadpf (id, proyectofinanciero_id, 
        resultadopf_id, nombrecorto, titulo, descripcion, actividadtipo_id)
        (SELECT id, 1, 1, id, nombre, 'Agregada automaticamente', NULL 
        FROM cor1440_gen_actividadtipo
         WHERE id<100 AND fechadeshabilitacion IS NULL);

      UPDATE cor1440_gen_actividadtipo SET fechadeshabilitacion = '2018-02-23',
        observaciones='Deshabilitado automaticamente' WHERE id<100;

      INSERT INTO cor1440_gen_actividad_proyectofinanciero (actividad_id,
        proyectofinanciero_id) (SELECT id, 1 FROM cor1440_gen_actividad);

      INSERT INTO cor1440_gen_actividad_actividadpf (actividad_id,
        actividadpf_id) (SELECT actividad_id, actividadtipo_id 
        FROM cor1440_gen_actividad_actividadtipo);

    SQL
  end
  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_actividad_actividadpf WHERE actividadpf_id IN
        (SELECT id FROM cor1440_gen_actividadtipo);

      DELETE FROM cor1440_gen_actividad_proyectofinanciero WHERE 
        proyectofinanciero_id='1';

      UPDATE cor1440_gen_actividadtipo SET fechadeshabilitacion=NULL,
        observaciones='' WHERE id<100 AND fechadeshabilitacion='2018-02-23'
        AND observaciones='Deshabilitado automaticamente';

      DELETE FROM cor1440_gen_actividadpf WHERE 
        descripcion='Agregada automaticamente';

      DELETE FROM cor1440_gen_resultadopf WHERE id='1';

      DELETE FROM cor1440_gen_objetivopf WHERE id='1';
      
      DELETE FROM cor1440_gen_proyectofinanciero WHERE id='1';
    SQL
  end
end
