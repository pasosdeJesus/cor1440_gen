class CreaActividadActividadtipo < ActiveRecord::Migration[4.2]
  def up
    if !connection.table_exists?(:cor1440_gen_actividadtipo)
      execute <<-SQL
        CREATE TABLE public.cor1440_gen_actividadtipo (
            id integer NOT NULL PRIMARY KEY,
            nombre character varying(500) NOT NULL,
            observaciones character varying(5000),
            fechacreacion date NOT NULL,
            fechadeshabilitacion date,
            created_at timestamp without time zone NOT NULL,
            updated_at timestamp without time zone NOT NULL,
            listadoasistencia boolean
        );
        
        CREATE SEQUENCE public.cor1440_gen_actividadtipo_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1;
        
        ALTER SEQUENCE public.cor1440_gen_actividadtipo_id_seq 
          OWNED BY public.cor1440_gen_actividadtipo.id;
      SQL
    end
    execute <<-SQL
        CREATE TABLE cor1440_gen_actividad_actividadtipo (
            actividad_id    INTEGER REFERENCES cor1440_gen_actividad(id),
            actividadtipo_id    INTEGER REFERENCES cor1440_gen_actividadtipo(id)
        );
    SQL
  end
  def down
    execute <<-SQL
        DROP TABLE cor1440_gen_actividad_actividadtipo;
    SQL
  end

end
