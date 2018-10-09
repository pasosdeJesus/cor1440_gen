# encoding: UTF-8

class CreateCor1440GenInforme < ActiveRecord::Migration[4.2]
  def change
    create_table :cor1440_gen_informe do |t|
      t.string :titulo, limit: 500, null: false
      t.date :filtrofechaini, null: false
      t.date :filtrofechafin, null: false
      t.integer :filtroproyecto
      t.integer :filtroactividadarea
      t.boolean :columnanombre
      t.boolean :columnatipo
      t.boolean :columnaobjetivo
      t.boolean :columnaproyecto
      t.boolean :columnapoblacion
      t.string :recomendaciones, limit: 5000
      t.string :avances, limit: 5000
      t.string :logros, limit: 5000
      t.string :dificultades, limit: 5000

      t.timestamps null: false
    end

    add_foreign_key :cor1440_gen_informe, :cor1440_gen_proyecto, 
      column: :filtroproyecto
    add_foreign_key :cor1440_gen_informe, :cor1440_gen_actividadarea, 
      column: :filtroactividadarea
  end
end
