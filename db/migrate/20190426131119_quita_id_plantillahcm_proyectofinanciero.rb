class QuitaIdPlantillahcmProyectofinanciero < ActiveRecord::Migration[5.2]
  def up
    # Es una tabla combinada sencillita
    remove_column :cor1440_gen_plantillahcm_proyectofinanciero, :id
  end
  def down
    add_column :cor1440_gen_plantillahcm_proyectofinanciero, :id, :integer
  end
end
