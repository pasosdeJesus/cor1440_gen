class CreaProyecto < ActiveRecord::Migration[4.2]
  def change
    create_table :cor1440_gen_proyecto do |t|
      t.string :nombre, limit: 1000
      t.string :observaciones, limit: 5000
      t.date :fechainicio
      t.date :fechacierre
      t.string :resultados, limit: 5000
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
