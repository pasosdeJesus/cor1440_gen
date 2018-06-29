class CreateActorsocial < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_actorsocial do |t|
      t.string :nombre, limit: 500, null: false
      #t.integer :personacontacto_id
      t.string :cargo, limit: 500
      t.string :correo, limit: 500
      t.string :telefono, limit: 500
      t.string :fax, limit: 500
      t.string :direccion, limit: 500
      t.integer :pais_id, index: true
      t.string :web, limit: 500
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
    #add_foreign_key :actorsocial, :sip_persona, column: :personacontacto_id
    add_foreign_key :cor1440_gen_actorsocial, :sip_pais, column: :pais_id
  end
end
