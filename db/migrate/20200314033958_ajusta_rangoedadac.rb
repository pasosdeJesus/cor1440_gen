class AjustaRangoedadac < ActiveRecord::Migration[6.0]
  def up
    if Cor1440Gen::Rangoedadac.where(id: 1).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 1, nombre: 'De 0 a 11', 
         limiteinferior: 0, limitesuperior: 11,
         fechacreacion: '2020-03-14'})
      r.save!
    else
      r = Cor1440Gen::Rangoedadac.find(1)
      if r.nombre == 'De 0 a 11' && (r.limiteinferior != 0 ||
          r.limitesuperior != 11)
        r.limiteinferior = 0
        r.limitesuperior = 11
        r.save!
      end
    end
    if Cor1440Gen::Rangoedadac.where(id: 2).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 2, nombre: 'De 12 a 17', 
         limiteinferior: 12, limitesuperior: 17,
         fechacreacion: '2020-03-14'})
      r.save!
    else
      r = Cor1440Gen::Rangoedadac.find(2)
      if r.nombre == 'De 12 a 17' && (r.limiteinferior != 12 ||
          r.limitesuperior != 17)
        r.limiteinferior = 12
        r.limitesuperior = 17
        r.save!
      end
    end
    if Cor1440Gen::Rangoedadac.where(id: 3).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 3, nombre: 'De 18 a 25', 
         limiteinferior: 18, limitesuperior: 25,
         fechacreacion: '2020-03-14'})
      r.save!
    else
      r = Cor1440Gen::Rangoedadac.find(3)
      if r.nombre == 'De 18 a 25' && (r.limiteinferior != 18 ||
          r.limitesuperior != 25)
        r.limiteinferior = 18
        r.limitesuperior = 25
        r.save!
      end
    end
    if Cor1440Gen::Rangoedadac.where(id: 4).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 4, nombre: 'De 26 a 45', 
         limiteinferior: 26, limitesuperior: 45,
         fechacreacion: '2020-03-14'})
      r.save!
    end
    if Cor1440Gen::Rangoedadac.where(id: 5).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 5, nombre: 'De 46 a 60', 
         limiteinferior: 46, limitesuperior: 60,
         fechacreacion: '2020-03-14'})
      r.save!
    end
    if Cor1440Gen::Rangoedadac.where(id: 6).count == 0
      r = Cor1440Gen::Rangoedadac.create(
        {id: 6, nombre: 'De 61 en adelante', 
         limiteinferior: 61, limitesuperior: nil,
         fechacreacion: '2020-03-14'})
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
