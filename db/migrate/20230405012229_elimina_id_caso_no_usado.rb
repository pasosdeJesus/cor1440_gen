class EliminaIdCasoNoUsado < ActiveRecord::Migration[7.0]
  def up
    if !table_exists?('sivel2_gen_caso') && 
        Msip::Ubicacion.columns.map(&:name).include?("id_caso") &&
        Msip::Ubicacion.where.not(id_caso: nil).count == 0
        remove_column :msip_ubicacion, :id_caso, cascade: true
    end
  end

  def down
  end
end
