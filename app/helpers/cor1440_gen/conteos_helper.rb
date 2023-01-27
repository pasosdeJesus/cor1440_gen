# frozen_string_literal: true

module Cor1440Gen
  module ConteosHelper
    # Da conteo de asistentes a un actividad como una tabla
    # por Rango de Edad y Sexo
    # @return diccionario primer índice es id de rango de edad,
    #         segundo índice es sexo ('F', 'M' o 'S')  (o el de
    #         la convención de la base de datos en ese orden).
    def genera_dicc_poblacion_de_asistentes(a)
      personas = {}
      a.asistencia.each do |asist|
        if !asist.persona
          merr = "Persona en NULL en asistencia #{asist.id} "\
            "de actividad #{a.id}"
          puts merr
          STDERR.puts merr
        elsif personas[asist.persona.id]
          merr = "Persona #{asist.persona.id} repetida en "\
            "listado de asistencia de la actividad #{a.id}"
          puts merr
          STDERR.puts merr
        else
          personas[asist.persona.id] = 1
        end
      end

      convF = Msip::Persona.convencion_sexo_abreviada[0]
      convM = Msip::Persona.convencion_sexo_abreviada[1]
      convS = Msip::Persona.convencion_sexo_abreviada[2]
      rangoedadsexo = {}
      personas.keys.sort.each do |pid|
        p = Msip::Persona.find(pid)
        edad = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
          p.anionac,
          p.mesnac,
          p.dianac,
          a.fecha.year,
          a.fecha.month,
          a.fecha.day,
        )
        re = Sivel2Gen::RangoedadHelper.buscar_rango_edad(
          edad, "Cor1440Gen::Rangoedadac"
        )
        unless rangoedadsexo[re]
          rangoedadsexo[re] = {}
          rangoedadsexo[re][convF] = 0
          rangoedadsexo[re][convM] = 0
          rangoedadsexo[re][convS] = 0
        end
        rangoedadsexo[re][p.sexo] += 1
      end

      rangoedadsexo
    end
    module_function :genera_dicc_poblacion_de_asistentes

    # Compara talba de población almacenada en base con la
    # que se genera del listado de asistencia
    # @return número de diferencias encontradas
    def compara_tabla_poblacion_asistentes_actividad(a)
      d = genera_dicc_poblacion_de_asistentes(a)

      numdif = 0

      convF = Msip::Persona.convencion_sexo_abreviada[0]
      convM = Msip::Persona.convencion_sexo_abreviada[1]
      convS = Msip::Persona.convencion_sexo_abreviada[2]

      res = Cor1440Gen::Rangoedadac.habilitados
      res.each do |re|
        tm = 0
        tf = 0
        ts = 0
        if a.actividad_rangoedadac &&
            a.actividad_rangoedadac.where(rangoedadac_id: re.id).count > 0
          are = a.actividad_rangoedadac.where(rangoedadac_id: re.id).take
          tm = are.mr
          tf = are.fr
          ts = are.s
        end
        dm = 0
        df = 0
        ds = 0
        if d[re.id]
          dm = d[re.id][convM]
          df = d[re.id][convF]
          ds = d[re.id][convS]
        end

        if tf != df
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convF}. "\
            "Tabla dice #{tf} y cuenta de asistentes da #{df}."
          numdif += 1
        end
        if tm != dm
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convM}. "\
            "Tabla dice #{tm} y cuenta de asistentes da #{dm}."
          numdif += 1
        end
        next unless ts != ds

        STDERR.puts "** Diferencia en actividad #{a.id}, "\
          "rango de edad #{re.id}, sexo #{convS}. "\
          "Tabla dice #{ts} y cuenta de asistentes da #{ds}."
        numdif += 1
      end

      numdif
    end
    module_function :compara_tabla_poblacion_asistentes_actividad

    # Cambia cantidades en un registro de rango de edad en una actividad
    # @param a Actividad
    # @param re  Rango de Edad
    # @param f Cantidad de mujere beneficiarias
    # @param m Cantidad de hombres beneficiarios
    # @param s Cantidad de beneficiarios sin sexo
    def cambia_actividad_rangoedadac(actividad, rangoedadac, f, m, s)
      acrs = Cor1440Gen::ActividadRangoedadac.where(actividad_id: actividad.id)
        .where(rangoedadac_id: rangoedadac.id)
      STDERR.puts "Cambiando actividad_id: #{actividad.id}, "\
        "rangoedadac_id: #{rangoedadac.id}, f: #{f}, m: #{m}, s: #{s}"
      if acrs.count > 0
        acr = acrs.take
        acr.fr = f
        acr.mr = m
        acr.s = s
        acr.save
      else
        acr = Cor1440Gen::ActividadRangoedadac.create(
          actividad_id: actividad.id,
          rangoedadac_id: rangoedadac.id,
          fr: f,
          mr: m,
          s: s,
        )
        acr.save
      end
    end
    module_function :cambia_actividad_rangoedadac

    # Arregla tabla de población almacenada en base a partir
    # del listado de asistencia.
    # @param a Actividad
    #
    # @param resultado Colchón para escribir resultados del arreglo
    # @return número de cambios efectuados
    def arregla_tabla_poblacion_de_asistentes_actividad(a, resultado)
      d = genera_dicc_poblacion_de_asistentes(a)

      numdif = 0

      convF = Msip::Persona.convencion_sexo_abreviada[0]
      convM = Msip::Persona.convencion_sexo_abreviada[1]
      convS = Msip::Persona.convencion_sexo_abreviada[2]

      res = Cor1440Gen::Rangoedadac.habilitados
      res.each do |re|
        tm = 0
        tf = 0
        ts = 0
        if a.actividad_rangoedadac &&
            a.actividad_rangoedadac.where(rangoedadac_id: re.id).count > 0
          are = a.actividad_rangoedadac.where(rangoedadac_id: re.id).take
          tm = are.mr
          tf = are.fr
          ts = are.s
        end
        dm = 0
        df = 0
        ds = 0
        if d[re.id]
          dm = d[re.id][convM]
          df = d[re.id][convF]
          ds = d[re.id][convS]
        end

        pref = "* Cambiando tabla de población de actividad '#{a.id}', "\
          "fila con rango de edad '#{re.nombre}': "

        numdifpre = numdif
        if tf != df
          numdif += 1
          resultado << "#{pref} #{convF} #{tf}->#{df}"
          pref = ", "
        end
        if tm != dm
          numdif += 1
          resultado << "#{pref} #{convM} #{tm}->#{dm}"
          pref = ", "
        end
        if ts != ds
          numdif += 1
          resultado << "#{pref} #{convS} #{ts}->#{ds}"
          pref = ", "
        end
        if (numdif - numdifpre) > 0
          cambia_actividad_rangoedadac(a, re, df, dm, ds)
          resultado << ".\n"
        end

        # Optimizamos eliminando filas en ceros
        next unless a.actividad_rangoedadac &&
          a.actividad_rangoedadac.where(rangoedadac_id: re.id).count > 0

        are = a.actividad_rangoedadac.where(rangoedadac_id: re.id).take
        tm = are.mr
        tf = are.fr
        ts = are.s
        if tm == 0 && tf == 0 && ts == 0
          are.destroy
        end
      end

      numdif
    end
    module_function :arregla_tabla_poblacion_de_asistentes_actividad

    # Compara tablas de población de todas las actividaddes
    # con conteos generados de asistentes
    # @return número de diferencias encontradas
    def compara_tablas_poblacion_asistentes
      numdif = 0
      Cor1440Gen::Actividad.all.each do |a|
        numdif += compara_tabla_poblacion_asistentes_actividad(a)
      end

      STDERR.puts "Total de diferencias: #{numdif}"
      numdif
    end
    module_function :compara_tablas_poblacion_asistentes

    # Arregla tablas de población de las actividades que recibe
    # con conteos generados de asistentes
    #
    # @parama actividades
    # @param resultado Colchón donde escribir resultados del arreglo
    # @return número de diferencias encontradas
    def arregla_tablas_poblacion(actividades, resultado)
      numdif = 0
      univ = actividades.count
      c = 0
      ultp = -1
      STDERR.puts "Por revisar #{univ} actividades"
      actividades.each do |a|
        c += 1
        por = c * 100 / univ
        if por / 10 != ultp / 10
          ultp = por
          STDERR.puts "#{por}%"
        end
        numdif += arregla_tabla_poblacion_de_asistentes_actividad(a, resultado)
      end
      resultado << "\nEn #{univ} actividades revisadas se realizaron #{numdif} cambios"
      numdif
    end
    module_function :arregla_tablas_poblacion

    # Arregla tablas de población de las actividades desde 2020
    # con conteos generados de asistentes
    #
    # @param resultado Colchón donde escribir resultados del arreglo
    # @return número de diferencias encontradas
    def arregla_tablas_poblacion_desde_2020(resultado)
      ActiveRecord::Base.connection.execute(<<-SQL)
      DROP VIEW IF EXISTS cor1440_gen_vista_resumentpob CASCADE;
      CREATE VIEW cor1440_gen_vista_resumentpob AS (
      SELECT * FROM (SELECT a.id AS actividad_id, ARRAY_TO_STRING(ARRAY(
            SELECT rangoedadac_id::text || ' ' || coalesce(fr::text,'0')
            || ' ' || coalesce(mr::text, '0') || ' ' || coalesce(s::text, '0')
            FROM cor1440_gen_actividad_rangoedadac
            WHERE actividad_id=a.id
            ORDER BY rangoedadac_id), ' | ') AS tpob
      FROM cor1440_gen_actividad AS a) AS sub
      WHERE sub.tpob <> ''
      ORDER BY 1
      );

      DROP VIEW IF EXISTS cor1440_gen_vista_asist_rangoe_sexo CASCADE;
      CREATE VIEW cor1440_gen_vista_asist_rangoe_sexo AS (
      SELECT actividad_id, rangoedadac_id, sexo, count(persona_id) AS cuenta
      FROM (SELECT sub.actividad_id, sub.persona_id, sexo, re.id AS rangoedadac_id
      FROM (SELECT asi.actividad_id, persona_id, p.sexo,
        msip_edad_de_fechanac_fecharef(p.anionac, p.mesnac, p.dianac,
          extract(year from a.fecha)::integer,
          extract(month from a.fecha)::integer,
          extract(day from a.fecha)::integer
        ) AS edad FROM  cor1440_gen_asistencia AS asi
        JOIN msip_persona AS p ON p.id=asi.persona_id
        JOIN cor1440_gen_actividad AS a ON a.id=asi.actividad_id) AS sub
      JOIN cor1440_gen_rangoedadac AS re ON (re.id = 7 AND sub.edad IS NULL) OR
        (re.id <> 7 AND re.limiteinferior<= sub.edad AND
          (re.limitesuperior IS NULL OR sub.edad <= re.limitesuperior))) AS sub2
      GROUP BY 1,2,3 ORDER BY 1, 2, 3
      );

      DROP VIEW IF EXISTS cor1440_gen_vista_tpoblacion_de_asist;
      CREATE VIEW cor1440_gen_vista_tpoblacion_de_asist AS (
      SELECT actividad_id, rangoedadac_id, coalesce(fn, 0) AS f,
        coalesce(mn, 0) AS m, coalesce(sn, 0) AS s
      FROM (
        SELECT DISTINCT actividad_id, rangoedadac_id, (SELECT cuenta
          FROM cor1440_gen_vista_asist_rangoe_sexo AS i
          WHERE i.actividad_id=v.actividad_id
          AND i.rangoedadac_id=v.rangoedadac_id
          AND sexo='F' LIMIT 1) AS fn, (SELECT cuenta
          FROM cor1440_gen_vista_asist_rangoe_sexo AS i
          WHERE i.actividad_id=v.actividad_id
          AND i.rangoedadac_id=v.rangoedadac_id
          AND sexo='M' LIMIT 1) AS mn, (SELECT cuenta
          FROM cor1440_gen_vista_asist_rangoe_sexo AS i
          WHERE i.actividad_id=v.actividad_id
          AND i.rangoedadac_id=v.rangoedadac_id
          AND sexo='S' LIMIT 1) AS sn
        FROM cor1440_gen_vista_asist_rangoe_sexo AS v
      ) AS sub
      );

      DROP MATERIALIZED VIEW IF EXISTS cor1440_gen_vista_resumentpob2;
      CREATE MATERIALIZED VIEW cor1440_gen_vista_resumentpob2 AS (
      SELECT * FROM (SELECT a.id as actividad_id, ARRAY_TO_STRING(ARRAY(
            SELECT rangoedadac_id::text || ' ' || coalesce(f::text,'0')
            || ' ' || coalesce(m::text, '0') || ' ' || coalesce(s::text, '0')
            FROM cor1440_gen_vista_tpoblacion_de_asist
            WHERE actividad_id=a.id
            ORDER BY rangoedadac_id), ' | ') AS tpob
      FROM cor1440_gen_actividad AS a) AS sub
      WHERE sub.tpob <> ''
      ORDER BY 1
      );
      SQL

      resc = ActiveRecord::Base.connection.execute(<<-SQL)
      SELECT * FROM cor1440_gen_actividad AS a
      LEFT JOIN cor1440_gen_vista_resumentpob AS r1
        ON a.id=r1.actividad_id
      LEFT JOIN cor1440_gen_vista_resumentpob2 AS r2
        ON a.id=r2.actividad_id
      WHERE a.fecha >='2020-01-01'
        AND coalesce(r1.tpob, '')<>coalesce(r2.tpob, '')
      ORDER BY a.id
      ;
      SQL
      ids = resc.pluck("id")
      ap = Cor1440Gen::Actividad.where(id: ids)
      arregla_tablas_poblacion(ap, resultado)
    end
    module_function :arregla_tablas_poblacion_desde_2020

    # Elimina tabla de población de una actividad y la recalcula con
    # listado de asistencia
    #
    # @param actividad
    def recalcula_poblacion(actividad)
      rangoedad = {}
      Cor1440Gen::ActividadRangoedadac
        .where(actividad_id: actividad.id).delete_all
      actividad.asistencia.each do |asis|
        per = asis.persona
        next unless per

        # puts "OJO per.id=#{per.id}, per.sexo=#{per.sexo}, per.fechanac=#{per.anionac.to_s}-#{per.mesnac.to_s}-#{per.dianac.to_s}"
        re = Msip::EdadSexoHelper.buscar_rango_edad(
          Msip::EdadSexoHelper.edad_de_fechanac_fecha(
            per.anionac,
            per.mesnac,
            per.dianac,
            actividad.fecha.year,
            actividad.fecha.month,
            actividad.fecha.day,
          ),
          "Cor1440Gen::Rangoedadac",
        )
        # puts "OJO re=#{re}"
        unless rangoedad[re]
          rangoedad[re] = {}
        end
        unless rangoedad[re][per.sexo]
          rangoedad[re][per.sexo] = 0
        end
        rangoedad[re][per.sexo] += 1
      end
      rangoedad.each do |re, vs|
        Cor1440Gen::ActividadRangoedadac.create(
          actividad_id: actividad.id,
          rangoedadac_id: re,
          mr: vs["M"].to_i,
          fr: vs["F"].to_i,
          s: vs["S"].to_i,
        )
      end
    end
    module_function :recalcula_poblacion


    def instala_calculo_poblacion_pg
      ActiveRecord::Base.connection.execute(<<-SQL)
        -- Suponemos que cor1440_gen_rangoedadac es consistente
        CREATE OR REPLACE PROCEDURE cor1440_gen_recalcular_poblacion_actividad(
          par_actividad_id BIGINT)
        LANGUAGE plpgsql
        AS $cuerpo$
        DECLARE
          rangos INTEGER ARRAY;
          idrangos INTEGER ARRAY;
          i INTEGER;
          a_dia INTEGER;
          a_mes INTEGER;
          a_anio INTEGER;
          asistente RECORD;
          edad INTEGER;
          rango_id INTEGER;
        BEGIN
          RAISE NOTICE 'actividad_id es %', par_actividad_id;
          SELECT EXTRACT(DAY FROM fecha) INTO a_dia FROM cor1440_gen_actividad
            WHERE id=par_actividad_id LIMIT 1;
          RAISE NOTICE 'a_dia es %', a_dia;
          SELECT EXTRACT(MONTH FROM fecha) INTO a_mes FROM cor1440_gen_actividad
            WHERE id=par_actividad_id;
          RAISE NOTICE 'a_mes es %', a_mes;
          SELECT EXTRACT(YEAR FROM fecha) INTO a_anio FROM cor1440_gen_actividad
            WHERE id=par_actividad_id;
          RAISE NOTICE 'a_anio es %', a_anio;

          DELETE FROM cor1440_gen_actividad_rangoedadac
            WHERE actividad_id=par_actividad_id
          ;

          FOR rango_id IN SELECT id FROM cor1440_gen_rangoedadac
            WHERE fechadeshabilitacion IS NULL
          LOOP
            INSERT INTO cor1440_gen_actividad_rangoedadac
              (actividad_id, rangoedadac_id, mr, fr, s, created_at, updated_at)
              (SELECT par_actividad_id, rango_id, 0, 0, 0, NOW(), NOW());
          END LOOP;

          FOR asistente IN SELECT p.id, p.anionac, p.mesnac, p.dianac, p.sexo
            FROM cor1440_gen_asistencia AS asi
            JOIN cor1440_gen_actividad AS ac ON ac.id=asi.actividad_id
            JOIN msip_persona AS p ON p.id=asi.persona_id
            WHERE ac.id=par_actividad_id
          LOOP
            RAISE NOTICE 'persona_id es %', asistente.id;
            edad = msip_edad_de_fechanac_fecharef(asistente.anionac, asistente.mesnac,
              asistente.dianac, a_anio, a_mes, a_dia);
            RAISE NOTICE 'edad es %', edad;
            SELECT id INTO rango_id FROM cor1440_gen_rangoedadac WHERE
              fechadeshabilitacion IS NULL AND
              limiteinferior <= edad AND 
                (limitesuperior IS NULL OR edad <= limitesuperior) LIMIT 1;
            IF rango_id IS NULL THEN
              rango_id := 7;
            END IF;
            RAISE NOTICE 'rango_id es %', rango_id;

            CASE asistente.sexo
              WHEN 'F' THEN
                UPDATE cor1440_gen_actividad_rangoedadac SET fr = fr + 1
                  WHERE actividad_id=par_actividad_id
                  AND rangoedadac_id=rango_id;
              WHEN 'M' THEN
                UPDATE cor1440_gen_actividad_rangoedadac SET mr = mr + 1
                  WHERE actividad_id=par_actividad_id
                  AND rangoedadac_id=rango_id;
              ELSE
                UPDATE cor1440_gen_actividad_rangoedadac SET s = s + 1
                  WHERE actividad_id=par_actividad_id
                  AND rangoedadac_id=rango_id;
            END CASE;
          END LOOP;

          DELETE FROM cor1440_gen_actividad_rangoedadac
            WHERE actividad_id = par_actividad_id
            AND mr = 0 AND fr = 0 AND s = 0
          ;
          RETURN;
        END;
        $cuerpo$;


        CREATE OR REPLACE FUNCTION cor1440_gen_actividad_cambiada()
          RETURNS trigger AS $ac$
          BEGIN
            ASSERT(TG_OP = 'UPDATE');
            ASSERT(NEW.id = OLD.id);
            CALL cor1440_gen_recalcular_poblacion_actividad(NEW.id);
            RETURN NULL;
          END ;
        $ac$ LANGUAGE plpgsql;

        CREATE OR REPLACE FUNCTION cor1440_gen_asistencia_cambiada_creada_eliminada()
          RETURNS trigger AS $ac$
          BEGIN
            CASE
              WHEN (TG_OP = 'UPDATE') THEN
                ASSERT(NEW.id = OLD.id);
                CALL cor1440_gen_recalcular_poblacion_actividad(NEW.actividad_id);
              WHEN (TG_OP = 'INSERT') THEN
                CALL cor1440_gen_recalcular_poblacion_actividad(NEW.actividad_id);
              ELSE -- DELETE
                CALL cor1440_gen_recalcular_poblacion_actividad(OLD.actividad_id);
            END CASE;
            RETURN NULL;
          END;
        $ac$ LANGUAGE plpgsql;

        CREATE OR REPLACE FUNCTION cor1440_gen_persona_cambiada()
          RETURNS trigger AS $ac$
        DECLARE
          aid INTEGER;
        BEGIN
          ASSERT(TG_OP = 'UPDATE');
          ASSERT(NEW.id = OLD.id);
          FOR aid IN 
            SELECT actividad_id FROM cor1440_gen_asistencia 
              WHERE persona_id=NEW.id
          LOOP
            CALL cor1440_gen_recalcular_poblacion_actividad(aid);
          END LOOP;
          RETURN NULL;
        END ;
        $ac$ LANGUAGE plpgsql;


        -- Solo agregamos trigger al cambiar actividad porque:
        -- Al crearse no habrá asistentes
        -- Cuando se elimine, se eliminarán los asistentes que tendrá
        -- triggers al eliminar
        CREATE OR REPLACE TRIGGER cor1440_gen_recalcular_tras_cambiar_actividad
          AFTER UPDATE ON cor1440_gen_actividad
          FOR EACH ROW EXECUTE FUNCTION cor1440_gen_actividad_cambiada()
        ;

        CREATE OR REPLACE TRIGGER cor1440_gen_recalcular_tras_cambiar_asistencia
          AFTER INSERT OR UPDATE OR DELETE ON cor1440_gen_asistencia
          FOR EACH ROW EXECUTE FUNCTION cor1440_gen_asistencia_cambiada_creada_eliminada()
        ;

        -- Solo agregamos trigger al cambiar persona porque:
        -- Al crearse no puede ser asistente.
        -- Cuando se elimine, se eliminarán las asistencias que tenía
        --   y eso ya disparará proceso de actualizar poblacion(es).
        CREATE OR REPLACE TRIGGER cor1440_gen_recalcular_tras_cambiar_persona
          AFTER UPDATE ON msip_persona
          FOR EACH ROW EXECUTE FUNCTION cor1440_gen_persona_cambiada()
        ;


       
      SQL
    end
    module_function :instala_calculo_poblacion_pg

    def desinstala_calculo_poblacion_pg
      ActiveRecord::Base.connection.execute(<<-SQL)
        -- Suponemos que cor1440_gen_rangoedadac es consistente

        DROP TRIGGER IF EXISTS cor1440_gen_recalcular_tras_cambiar_persona
          ON msip_persona;
        DROP TRIGGER IF EXISTS cor1440_gen_recalcular_tras_cambiar_actividad
          ON cor1440_gen_asistencia;
        DROP TRIGGER IF EXISTS cor1440_gen_recalcular_tras_cambiar_actividad
          ON cor1440_gen_tras_cambiar_actividad;
        DROP FUNCTION IF EXISTS 
          cor1440_gen_asistencia_cambiada_creada_eliminada CASCADE;
        DROP FUNCTION IF EXISTS cor1440_gen_persona_cambiada CASCADE;
        DROP FUNCTION IF EXISTS cor1440_gen_actividad_cambiada CASCADE;
        DROP PROCEDURE IF EXISTS cor1440_gen_recalcular_poblacion_actividad 
          CASCADE;
      SQL
    end
    module_function :desinstala_calculo_poblacion_pg
 
  end
end
