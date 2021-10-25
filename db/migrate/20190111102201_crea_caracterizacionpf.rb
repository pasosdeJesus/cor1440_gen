class CreaCaracterizacionpf < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_caracterizacionpf, id: false do |t|
      t.integer :formulario_id
      t.integer :proyectofinanciero_id
    end
    add_foreign_key :cor1440_gen_caracterizacionpf, 
      :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_caracterizacionpf, :mr519_gen_formulario,
      column: :formulario_id
  end
end
