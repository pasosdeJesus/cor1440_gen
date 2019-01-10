class CreaCaracterizacionpersona < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_caracterizacionpersona do |t|
      t.integer :proyectofinanciero_id, null: false
      t.integer :persona_id, null: false
      t.integer :respuestafor_id, null: false
      t.integer :ulteditor_id, null: false
    end
    add_foreign_key :cor1440_gen_caracterizacionpersona,  
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_caracterizacionpersona,  
      :sip_persona, column: :persona_id
    add_foreign_key :cor1440_gen_caracterizacionpersona,  
      :mr519_gen_respuestafor, column: :respuestafor_id
    add_foreign_key :cor1440_gen_caracterizacionpersona,  
      :usuario, column: :ulteditor_id
  end
end
