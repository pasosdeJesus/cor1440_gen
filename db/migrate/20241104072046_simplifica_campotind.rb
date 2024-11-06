class SimplificaCampotind < ActiveRecord::Migration[7.2]
  def change
    drop_table :cor1440_gen_actividad_valorcampotind
    drop_table :cor1440_gen_valorcampotind
    drop_table :cor1440_gen_campotind
  end
end
