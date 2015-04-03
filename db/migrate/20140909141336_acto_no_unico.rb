class ActoNoUnico < ActiveRecord::Migration
  def change
    # en diversas fechas puede ocurrir lo mismo
    execute "ALTER TABLE acto DROP CONSTRAINT IF EXISTS
        acto_id_presponsable_id_categoria_id_persona_id_caso_key"
  end
end
