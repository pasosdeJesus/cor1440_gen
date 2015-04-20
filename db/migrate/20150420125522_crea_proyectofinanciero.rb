class CreaProyectofinanciero < ActiveRecord::Migration
  def change
    create_table :cor1440_gen_proyectofinanciero do |t|
      t.string :nombre, limit: 1000
      t.references :financiador
      t.references :proyecto
      t.string :observaciones, limit: 5000
      t.date :fechainicio
      t.date :fechacierre
      t.integer :responsable_id
      t.date :fechacreacion
      t.date :fechadeshabilitacion
      t.timestamp :created_at
      t.timestamp :updated_at
    end

    add_foreign_key :cor1440_gen_proyectofinanciero, :cor1440_gen_financiador, column: :financiador_id, primary_key: "id", name: "lf_proyectofinanciero_financiador"
    add_foreign_key :cor1440_gen_proyectofinanciero, :cor1440_gen_proyecto, column: :proyecto_id, primary_key: "id", name: "lf_proyectofinanciero_proyecto"
    add_foreign_key :cor1440_gen_proyectofinanciero, :usuario, column: :responsable_id, primary_key: "id", name: "lf_proyectofinanciero_responsable"
  end
end
