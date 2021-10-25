class CreaPlantillahcmProyectofinanciero < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_plantillahcm_proyectofinanciero do |t|
      t.integer :plantillahcm_id
      t.integer :proyectofinanciero_id
    end
    add_foreign_key :cor1440_gen_plantillahcm_proyectofinanciero,
      :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_plantillahcm_proyectofinanciero,
      :heb412_gen_plantillahcm,
      column: :plantillahcm_id
  end
end
