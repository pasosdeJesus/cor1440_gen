# encoding: UTF-8

class CreaFormularioTipoindicador < ActiveRecord::Migration[6.0]
  def change

    create_table :cor1440_gen_formulario_tipoindicador, id: false do |t|
      t.integer :tipoindicador_id, null: false
      t.integer :formulario_id, null: false
    end
    add_foreign_key :cor1440_gen_formulario_tipoindicador,  
     :cor1440_gen_tipoindicador, column: :tipoindicador_id
    add_foreign_key :cor1440_gen_formulario_tipoindicador,  
      :mr519_gen_formulario, column: :formulario_id
  end
end
