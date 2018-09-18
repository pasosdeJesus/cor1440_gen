class ActorsocialASip < ActiveRecord::Migration[5.2]
  def change
    drop_table :cor1440_gen_sectoractor
    drop_table :cor1440_gen_actorsocial
    # No usadas en produccion
  end
end
