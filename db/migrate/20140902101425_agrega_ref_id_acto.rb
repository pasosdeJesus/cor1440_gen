#encoding: UTF-8
class AgregaRefIdActo < ActiveRecord::Migration
  def up

    execute "ALTER TABLE actosjr 
            DROP CONSTRAINT IF EXISTS actosjr_id_persona_fkey1;"
    execute "ALTER TABLE actosjr 
            DROP CONSTRAINT IF EXISTS actosjr_id_caso_fkey1;"
    execute "ALTER TABLE actosjr 
            DROP CONSTRAINT IF EXISTS actosjr_id_categoria_fkey1;"
    execute "ALTER TABLE actosjr 
            DROP CONSTRAINT IF EXISTS actosjr_id_presponsable_fkey1;"
    execute "ALTER TABLE actosjr ADD CONSTRAINT acto_fkey
            FOREIGN KEY (id_caso, id_presponsable, id_categoria, id_persona) 
            REFERENCES acto(id_caso, id_presponsable, id_categoria, id_persona);"
    execute "ALTER TABLE actosjr ADD COLUMN id_acto INTEGER 
            REFERENCES acto(id);"
    execute "UPDATE actosjr SET id_acto=acto.id FROM acto
            WHERE actosjr.id_persona=acto.id_persona 
            AND actosjr.id_caso=acto.id_caso
            AND actosjr.id_presponsable=acto.id_presponsable
            AND actosjr.id_categoria=acto.id_categoria ;"
   
    execute "ALTER TABLE actosjr ADD UNIQUE(id_acto);"

    execute "ALTER TABLE actosjr DROP COLUMN id_persona;"
    execute "ALTER TABLE actosjr DROP COLUMN id_caso;"
    execute "ALTER TABLE actosjr DROP COLUMN id_presponsable;"
    execute "ALTER TABLE actosjr DROP COLUMN id_categoria;"
  end
  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
