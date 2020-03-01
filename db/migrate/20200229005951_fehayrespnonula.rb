class Fehayrespnonula < ActiveRecord::Migration[6.0]
  def change
    change_column_null :cor1440_gen_actividad, :fecha, false
    change_column_null :cor1440_gen_actividad, :usuario_id, false
  end
end
