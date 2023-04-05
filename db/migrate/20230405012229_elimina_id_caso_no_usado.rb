class EliminaIdCasoNoUsado < ActiveRecord::Migration[7.0]
  def up
    if (Msip::Ubicacion.where.not(id_caso: nil).count == 0) 
      remove_column :msip_ubicacion, :id_caso
    end
  end

  def down
  end
end
