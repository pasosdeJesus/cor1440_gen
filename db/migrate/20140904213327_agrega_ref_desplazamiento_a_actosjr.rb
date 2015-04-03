#encoding: UTF-8
class AgregaRefDesplazamientoAActosjr < ActiveRecord::Migration
  def up
    execute "ALTER TABLE actosjr
            DROP CONSTRAINT IF EXISTS actosjr_fechaexpulsion_fkey1"
    execute "ALTER TABLE actosjr ADD COLUMN desplazamiento_id INTEGER 
            REFERENCES desplazamiento(id)"
    execute "UPDATE actosjr SET desplazamiento_id=desplazamiento.id FROM desplazamiento, acto
            WHERE actosjr.id_acto=acto.id 
            AND acto.id_caso=desplazamiento.id_caso
            AND desplazamiento.fechaexpulsion = actosjr.fechaexpulsion"
    execute "ALTER TABLE actosjr DROP COLUMN fechaexpulsion"
  end
  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
