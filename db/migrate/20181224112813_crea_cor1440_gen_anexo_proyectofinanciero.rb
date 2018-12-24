class CreaCor1440GenAnexoProyectofinanciero < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_anexo_proyectofinanciero do |t|
      t.integer :anexo_id
      t.integer :proyectofinanciero_id
    end
    add_foreign_key :cor1440_gen_anexo_proyectofinanciero, 
      :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_anexo_proyectofinanciero, 
      :sip_anexo, column: :anexo_id
  end
end
