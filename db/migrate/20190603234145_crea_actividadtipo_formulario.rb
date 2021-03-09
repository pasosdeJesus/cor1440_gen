class CreaActividadtipoFormulario < ActiveRecord::Migration[6.0]
  def change

    create_table :cor1440_gen_actividadtipo_formulario, id: false do |t|
      t.integer :actividadtipo_id, null: false
      t.integer :formulario_id, null: false
    end
    add_foreign_key :cor1440_gen_actividadtipo_formulario,  
     :cor1440_gen_actividadtipo, column: :actividadtipo_id
    add_foreign_key :cor1440_gen_actividadtipo_formulario,  
      :mr519_gen_formulario, column: :formulario_id
  end
end
