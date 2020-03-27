class AjustaRangoedadac < ActiveRecord::Migration[6.0]
  def up
    r = Cor1440Gen::Rangoedadac.find(1)
    if r.nombre == 'De 0 a 11' && (r.limiteinferior != 0 ||
        r.limitesuperior != 11)
      r.limiteinferior = 0
      r.limitesuperior = 11
      r.save!
    end
    r = Cor1440Gen::Rangoedadac.find(2)
    if r.nombre == 'De 12 a 17' && (r.limiteinferior != 12 ||
        r.limitesuperior != 17)
      r.limiteinferior = 12
      r.limitesuperior = 17
      r.save!
    end
    r = Cor1440Gen::Rangoedadac.find(3)
    if r.nombre == 'De 18 a 25' && (r.limiteinferior != 18 ||
        r.limitesuperior != 25)
      r.limiteinferior = 18
      r.limitesuperior = 25
      r.save!
    end
    if Cor1440Gen::Rangoedadac.where(id: 7).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 7, nombre: 'SIN INFORMACIÓN', 
         limiteinferior: -1, limitesuperior: -1,
         fechacreacion: '2020-03-14'})
      r.save!
    end
  end


  def down
  end
end
