# encoding: UTF-8

class CreaActividadRespuestafor < ActiveRecord::Migration[6.0]
  def change
    create_table :cor1440_gen_actividad_respuestafor, id: false do |t|
      t.integer :actividad_id, null: false
      t.integer :respuestafor_id, null: false
    end
    add_foreign_key :cor1440_gen_actividad_respuestafor,  
     :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :cor1440_gen_actividad_respuestafor,  
      :mr519_gen_respuestafor, column: :respuestafor_id
  end
end
