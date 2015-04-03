class AgregaIdADesplazamiento < ActiveRecord::Migration
  def up
   execute "DROP SEQUENCE IF EXISTS desplazamiento_seq"
   execute "CREATE SEQUENCE desplazamiento_seq"
   # La siguiente tuvo que hacerse a mano en base de datos.
   execute "ALTER TABLE desplazamiento DROP CONSTRAINT 
        IF EXISTS desplazamiento_pkey CASCADE"
   execute "ALTER TABLE desplazamiento ADD 
        UNIQUE(id_caso, fechaexpulsion)"
   execute "ALTER TABLE desplazamiento ADD COLUMN id INTEGER 
        NOT NULL UNIQUE DEFAULT(nextval('desplazamiento_seq'))"
   execute "ALTER TABLE desplazamiento 
        ADD CONSTRAINT desplazamiento_pkey PRIMARY KEY (id)"
  end
  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
