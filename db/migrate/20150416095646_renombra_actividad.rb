class RenombraActividad < ActiveRecord::Migration[4.2]
  def up
    if connection.table_exists?(:sivel2_gen_actividad)
      execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividad_id_seq 
        RENAME TO cor1440_gen_actividad_id_seq
      SQL

      execute <<-SQL
      ALTER TABLE sivel2_gen_actividad 
        RENAME TO cor1440_gen_actividad;
      SQL

      execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividad_rangoedadac_id_seq 
        RENAME TO cor1440_gen_actividad_rangoedadac_id_seq
      SQL

      execute <<-SQL
      ALTER TABLE sivel2_gen_actividad_rangoedadac 
        RENAME TO cor1440_gen_actividad_rangoedadac;
      SQL

      execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividadarea_id_seq 
        RENAME TO cor1440_gen_actividadarea_id_seq
      SQL

      execute <<-SQL
      ALTER TABLE sivel2_gen_actividadarea 
        RENAME TO cor1440_gen_actividadarea;
      SQL

      execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividadareas_actividad_id_seq 
        RENAME TO cor1440_gen_actividadareas_actividad_id_seq
      SQL

      execute <<-SQL
      ALTER TABLE sivel2_gen_actividadareas_actividad 
        RENAME TO cor1440_gen_actividadareas_actividad;
      SQL

      execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_rangoedadac_id_seq 
        RENAME TO cor1440_gen_rangoedadac_id_seq
      SQL
      execute <<-SQL
      ALTER TABLE sivel2_gen_rangoedadac 
        RENAME TO cor1440_gen_rangoedadac;
      SQL

    elsif !connection.table_exists?(:cor1440_gen_actividad)

      execute <<-SQL
        CREATE TABLE public.cor1440_gen_actividad (
            id integer NOT NULL PRIMARY KEY,
            minutos integer,
            nombre character varying(500),
            objetivo character varying(5000),
            resultado character varying(5000),
            fecha date,
            observaciones character varying(5000),
            created_at timestamp without time zone,
            updated_at timestamp without time zone,
            oficina_id integer NOT NULL,
            rangoedadac_id integer,
            proyecto integer
        );
        
        CREATE SEQUENCE public.cor1440_gen_actividad_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        
        ALTER SEQUENCE public.cor1440_gen_actividad_id_seq OWNED BY public.cor1440_gen_actividad.id;
        
        -- rangoedadac
        
        CREATE TABLE public.cor1440_gen_rangoedadac (
            id integer NOT NULL,
            nombre character varying(255),
            limiteinferior integer,
            limitesuperior integer,
            fechacreacion date,
            fechadeshabilitacion date,
            created_at timestamp without time zone,
            updated_at timestamp without time zone
        );
        
        CREATE SEQUENCE public.cor1440_gen_rangoedadac_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        ALTER SEQUENCE public.cor1440_gen_rangoedadac_id_seq OWNED BY public.cor1440_gen_rangoedadac.id;
        
        -- actividad_rangoedadac
        
        CREATE TABLE public.cor1440_gen_actividad_rangoedadac (
            id integer NOT NULL,
            actividad_id integer,
            rangoedadac_id integer,
            ml integer,
            mr integer,
            fl integer,
            fr integer,
            created_at timestamp without time zone,
            updated_at timestamp without time zone
        );
        
        CREATE SEQUENCE public.cor1440_gen_actividad_rangoedadac_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        ALTER SEQUENCE public.cor1440_gen_actividad_rangoedadac_id_seq OWNED BY public.cor1440_gen_actividad_rangoedadac.id;
        
        -- actividadarea
        
        CREATE TABLE public.cor1440_gen_actividadarea (
            id integer NOT NULL PRIMARY KEY,
            nombre character varying(500),
            observaciones character varying(5000),
            fechacreacion date DEFAULT ('now'::text)::date,
            fechadeshabilitacion date,
            created_at timestamp without time zone,
            updated_at timestamp without time zone
        );
        
        CREATE SEQUENCE public.cor1440_gen_actividadarea_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        
        ALTER SEQUENCE public.cor1440_gen_actividadarea_id_seq 
          OWNED BY public.cor1440_gen_actividadarea.id;
        
        -- actividadareas_actividad
        CREATE TABLE public.cor1440_gen_actividadareas_actividad (
            id integer NOT NULL,
            actividad_id integer,
            actividadarea_id integer,
            created_at timestamp without time zone,
            updated_at timestamp without time zone
        );
        
        CREATE SEQUENCE public.cor1440_gen_actividadareas_actividad_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        ALTER SEQUENCE public.cor1440_gen_actividadareas_actividad_id_seq OWNED BY public.cor1440_gen_actividadareas_actividad.id;
      SQL
    end
  end



  def down
    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_rangoedadac_id_seq 
        RENAME TO sivel2_gen_rangoedadac_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_rangoedadac 
        RENAME TO sivel2_gen_rangoedadac;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividadareas_actividad_id_seq 
        RENAME TO sivel2_gen_actividadareas_actividad_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividadareas_actividad 
        RENAME TO sivel2_gen_actividadareas_actividad;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividadarea_id_seq 
        RENAME TO sivel2_gen_actividadarea_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividadarea 
        RENAME TO sivel2_gen_actividadarea;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividad_rangoedadac_id_seq 
        RENAME TO sivel2_gen_actividad_rangoedadac_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_rangoedadac 
        RENAME TO sivel2_gen_actividad_rangoedadac;
    SQL


    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividad_id_seq 
        RENAME TO sivel2_gen_actividad_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad 
        RENAME TO sivel2_gen_actividad;
    SQL




  end
end
