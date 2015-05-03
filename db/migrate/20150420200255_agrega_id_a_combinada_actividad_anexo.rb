class AgregaIdACombinadaActividadAnexo < ActiveRecord::Migration
  def up
    execute <<-SQL
     CREATE SEQUENCE cor1440_gen_actividad_sip_anexo_id_seq;
    SQL
    execute <<-SQL
    ALTER TABLE cor1440_gen_actividad_sip_anexo 
      ADD COLUMN id INTEGER 
        NOT NULL UNIQUE 
        DEFAULT(nextval('cor1440_gen_actividad_sip_anexo_id_seq'));
    SQL
    execute <<-SQL
    ALTER TABLE cor1440_gen_actividad_sip_anexo 
      ADD CONSTRAINT cor1440_gen_actividad_sip_anexo_pkey PRIMARY KEY (id);
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_sip_anexo
        DROP COLUMN id;
    SQL
    execute <<-SQL
      DROP SEQUENCE cor1440_gen_actividad_sip_anexo_id_seq;
    SQL
  end

end
