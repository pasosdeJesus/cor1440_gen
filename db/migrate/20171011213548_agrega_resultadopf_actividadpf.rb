class AgregaResultadopfActividadpf < ActiveRecord::Migration[5.1]
  def change
    add_column :actividadpf, :resultadopf_id, :integer
    add_foreign_key :actividadpf, :resultadopf,
      column: :resultadopf_id
  end
end
