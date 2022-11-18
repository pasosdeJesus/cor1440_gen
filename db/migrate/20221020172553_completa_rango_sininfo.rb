class CompletaRangoSininfo < ActiveRecord::Migration[7.0]
  def up
    if Cor1440Gen::Rangoedadac.where(id: 7).count == 0
      Cor1440Gen::Rangoedadac.create!(
        id: 7,
        nombre: 'Sin Información',
        limiteinferior: -1,
        limitesuperior: -1,
        fechacreacion: '2015-03-10'
      )
    end
  end
  def down
  end
end
