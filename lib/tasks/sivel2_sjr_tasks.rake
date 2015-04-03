# encoding: UTF-8

require 'active_support/core_ext/object/inclusion'
require 'active_record'

# Estas tareas se ejecutarán en orden después de las de sivel2_gen/lib/tasks/sivel2_gen_tasks.rake
namespace :sivel2 do

  desc "Vuelca novedades a tablas básicas en orden"
  task vuelcabasicasn: :environment do
    puts "sivel2_sjr - vuelcabasicasn"
		abcs = ActiveRecord::Base.configurations
    set_psql_env(abcs[Rails.env])
    search_path = abcs[Rails.env]['schema_search_path']
    connection = ActiveRecord::Base.connection()
  
    # Nuevas superbasicas
    
    # Nuevas 
    tb = [ 
      "acreditacion", "actividadoficio", "aslegal", "aspsicosocial", "ayudaestado", "ayudasjr",
      "clasifdesp", "comosupo", 
      "declaroante", "derecho",
      "emprendimiento", "escolaridad", "estadocivil",
      "idioma", "inclusion",
      "maternidad", "modalidadtierra", "motivosjr",
      "personadesea", "progestado", "proteccion",
      "rolfamilia",
      "statusmigratorio",
      "tipodesp"
    ]
    unless search_path.blank?
      search_path = search_path.split(",").map{|search_path_part| 
        "--schema=#{Shellwords.escape(search_path_part.strip)}" 
      }.join(" ")
    end
    archt = Dir::Tmpname.make_tmpname(["/tmp/vb", ".sql"], nil)
		filename = "db/datos-basicasn.sql"
    File.open(filename, "w") { |f| f << "-- Volcado de novedades a tablas basicas\n\n
      " 
      # Primero cambios a basicas existentes
      # tviolencia, supracategoria, categoria, etiqueta, regionsjr
      f << "
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = public, pg_catalog;

INSERT INTO tviolencia (id, nombre, nomcorto, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES ('R', 'DERECHO INTERNACIONAL REFUGIO', 'REF', '2014-06-19', NULL, '2014-06-19 13:20:35.26809', '2014-06-19 13:20:35.26809');
INSERT INTO tviolencia (id, nombre, nomcorto, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES ('S', 'SJR', 'SJR', '2013-06-25', NULL, NULL, NULL);

INSERT INTO supracategoria (id, nombre, fechacreacion, fechadeshabilitacion, id_tviolencia, created_at, updated_at) VALUES (100, 'SJR', '2013-06-25', NULL, 'S', NULL, NULL);
INSERT INTO supracategoria (id, nombre, fechacreacion, fechadeshabilitacion, id_tviolencia, created_at, updated_at) VALUES (200, 'CONVENCIÓN 1951', '2014-06-19', NULL, 'R', '2014-06-19 13:21:34.529277', '2014-06-19 13:21:34.529277');
INSERT INTO supracategoria (id, nombre, fechacreacion, fechadeshabilitacion, id_tviolencia, created_at, updated_at) VALUES (201, 'DECLARACIÓN DE CARTAGENA', '2014-06-19', NULL, 'R', '2014-06-19 13:22:02.263703', '2014-06-19 13:22:02.263703');
INSERT INTO supracategoria (id, nombre, fechacreacion, fechadeshabilitacion, id_tviolencia, created_at, updated_at) VALUES (202, 'PACTO DE SAN JOSÉ', '2014-06-19', NULL, 'R', '2014-06-19 13:22:21.815264', '2014-06-19 13:22:21.815264');
INSERT INTO supracategoria (id, nombre, fechacreacion, fechadeshabilitacion, id_tviolencia, created_at, updated_at) VALUES (203, 'ACNUR', '2014-06-19', NULL, 'R', '2014-06-19 13:22:39.94622', '2014-06-19 13:22:39.94622');

INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10002, 'AMENAZAS INDIRECTAS', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10003, 'AMETRALLAMIENTOS/BOMBARDEO', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10006, 'CAMPOS MINADOS/MUNICIONES SIN DETONAR', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10007, 'CONFRONTACIONES POR ACTORES ARMADOS', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10011, 'ERRADICACIÓN Y FUMIGACIONES', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10013, 'PRESENCIA GUERRILLERA', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10014, 'PARAMILITARIZACIÓN', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10015, 'MILITARIZACIÓN', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10017, 'MEGAPROYECTO DE MINERÍA', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10018, 'MEGAPROYECTO DE PALMA', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10019, 'MEGAPROYECTO DE PUERTOS', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10020, 'ORIENTACIÓN SEXUAL', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10021, 'RECLUTAMIENTO Y VINCULACIÓN DE NNAJ', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10022, 'POR PERTENECER A UN GRUPO SOCIAL', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10025, 'CONFINAMIENTO', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (10026, 'TEMOR FUNDADO', '2013-06-25', NULL, 100, 'S', NULL, NULL, 'I', NULL, NULL);

INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2000, 'RAZA', '2014-06-19', NULL, 200, 'R', NULL, NULL, 'I', '2014-06-19 13:24:33.302509', '2014-06-19 13:24:33.302509');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2001, 'RELIGIÓN', '2014-06-19', NULL, 200, 'R', NULL, NULL, 'I', '2014-06-19 13:25:07.240997', '2014-06-19 13:25:07.240997');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2002, 'NACIONALIDAD', '2014-06-19', NULL, 200, 'R', NULL, NULL, 'I', '2014-06-19 13:25:45.892889', '2014-06-19 13:25:45.892889');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2003, 'PERTENENCIA A GRUPO SOCIAL', '2014-06-19', NULL, 200, 'R', NULL, NULL, 'I', '2014-06-19 13:27:12.030191', '2014-06-19 13:27:12.030191');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2004, 'OPINIÓN POLÍTICA', '2014-06-19', NULL, 200, 'R', NULL, NULL, 'I', '2014-06-19 13:27:36.467502', '2014-06-19 13:27:36.467502');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2010, 'VIOLENCIA GENERALIZADA', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:28:32.228075', '2014-06-19 13:28:32.228075');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2011, 'DESASTRES NATURALES', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:29:04.757464', '2014-06-19 13:29:04.757464');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2012, 'AGRESIÓN EXTRANJERA', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:29:43.926042', '2014-06-19 13:29:43.926042');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2013, 'CONFLICTOS INTERNOS', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:30:15.105941', '2014-06-19 13:30:15.105941');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2014, 'VIOLACIÓN MASIVA DE DERECHOS HUMANOS', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:30:42.503981', '2014-06-19 13:30:42.503981');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2015, 'CIRCUNSTANCIAS QUE HAYAN PERTURBADO GRAVEMENTE EL ORDEN PÚBLICO', '2014-06-19', NULL, 201, 'R', NULL, NULL, 'I', '2014-06-19 13:31:13.421844', '2014-06-19 13:31:13.421844');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2020, 'GENERO', '2014-06-19', NULL, 202, 'R', NULL, NULL, 'I', '2014-06-19 13:32:21.608943', '2014-06-19 13:33:36.90906');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2021, 'CAUSAS ECONÓMICAS', '2014-06-19', NULL, 202, 'R', NULL, NULL, 'I', '2014-06-19 13:32:52.432009', '2014-06-19 13:33:27.82717');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2022, 'GRUPOS ÉTNICOS', '2014-06-19', NULL, 202, 'R', NULL, NULL, 'I', '2014-06-19 13:33:15.710791', '2014-06-19 13:33:15.710791');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2030, 'PERSECUCIÓN', '2014-06-19', NULL, 203, 'R', NULL, NULL, 'I', '2014-06-19 13:34:24.889437', '2014-06-19 13:34:24.889437');
INSERT INTO categoria (id, nombre, fechacreacion, fechadeshabilitacion, id_supracategoria, id_tviolencia, id_pconsolidado, contadaen, tipocat, created_at, updated_at) VALUES (2031, 'ORIENTACIÓN SEXUAL', '2014-06-19', NULL, 203, 'R', NULL, NULL, 'I', '2014-06-19 13:34:58.178604', '2014-06-19 13:34:58.178604');

INSERT INTO etiqueta (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (11, 'COMPARTIR CON SJR COLOMBIA', '', '2001-01-01', NULL, NULL, NULL);
INSERT INTO etiqueta (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (12, 'COMPARTIR CON SJR LATINOAMÉRICA', '', '2001-01-01', NULL, NULL, NULL);
INSERT INTO etiqueta (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'COMPARTIR CON BANCO DE DATOS CINEP COLOMBIA', '', '2001-01-01', NULL, NULL, NULL);

INSERT INTO regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SIN INFORMACIÓN', '2013-05-13', NULL, NULL, NULL);
INSERT INTO regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (100, 'ALTO APURE', '2014-01-21', NULL, NULL, NULL);
INSERT INTO regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (101, 'ZULIA', '2014-01-21', NULL, NULL, NULL);
INSERT INTO regionsjr (id, nombre, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (102, 'TÁCHIRA', '2014-01-21', NULL, NULL, NULL); "
      tb.each do |t|
        command = "pg_dump -i -a -x -O --column-inserts -t #{t}  " +
          "#{search_path} #{Shellwords.escape(abcs[Rails.env]['database'])} | " +
          " sed -e \"s/SET lock_timeout = 0;//g\" > #{archt}"
        puts command
        raise "Error al volcar tabla #{t}" unless Kernel.system(command)
        inserto = false
        ordeno = false
        porord = []
        # Agrega volcado pero ordenando los INSERTS
        # (pues pg_dump reordena arbitrariamente haciendo que entre
        # un volcado y otro se vean diferencias con diff cuando no hay)
        File.open(archt, "r") { |ent| 
          ent.each_line { |line| 
            if line[0,6] == "INSERT"
              inserto=true
              porord << line
            else
              if !inserto || (inserto && ordeno) 
                f << line
              else
                porord.sort!
                porord.each { |l|
                  f << l
                }
                ordeno = true
                f << line
              end
            end
          }
        }
      end

      f << "
      -- 
      " 
    }
  end

end

# de https://github.com/opdemand/puppet-modules/blob/master/rails/files/databases.rake
def set_psql_env(config)
	ENV['PGHOST']     = config['host']          if config['host']
	ENV['PGPORT']     = config['port'].to_s     if config['port']
	ENV['PGPASSWORD'] = config['password'].to_s if config['password']
	ENV['PGUSER']     = config['username'].to_s if config['username']
end
