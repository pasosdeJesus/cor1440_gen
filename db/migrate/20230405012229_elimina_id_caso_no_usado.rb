class EliminaIdCasoNoUsado < ActiveRecord::Migration[7.0]
  def up
    if (!table_exists?('sivel2_gen_caso'))
      if Msip::Ubicacion.where.not(id_caso: nil).count == 0
        remove_column :msip_ubicacion, :id_caso, cascade: true
      end
      if Msip::Ubicacion.where.not(caso_id: nil).count == 0 
        remove_column :msip_ubicacion, :caso_id, cascade: true
      end
    end
  end

  def down
  end
end
