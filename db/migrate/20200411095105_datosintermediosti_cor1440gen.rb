class DatosintermediostiCor1440gen < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      UPDATE cor1440_gen_tipoindicador 
        SET esptipometa='Numéro de actividades',
        espfuncionmedir='Cuenta actividades' WHERE id=1;
      UPDATE cor1440_gen_tipoindicador 
        SET esptipometa='Número de personas rep.',
        espfuncionmedir='Suma personas contadas en tablas de población de las actividades. Pueden haber repetidas.' WHERE id=2;
      UPDATE cor1440_gen_tipoindicador 
        SET esptipometa='Número de personas rep.',
        espfuncionmedir='Cuenta personas en listados de asistencia de actividades. Pueden haber repetidas' WHERE id=3;
      UPDATE cor1440_gen_tipoindicador 
        SET esptipometa='Número de personas únicas',
        espfuncionmedir='Cuenta personas únicas en listados de asistencia de actividades. Un participante que esté en listado de dos o más actividades actividades diferentes cuenta una sóla vez.' WHERE id=4;
    SQL
    d = Cor1440Gen::Datointermedioti.new(
      id: 1, tipoindicador_id: 2,
      nombre: 'Mujeres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 2, tipoindicador_id: 2,
      nombre: 'Hombres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 3, tipoindicador_id: 2,
      nombre: 'Sin Sexo de Nacimiento'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 4, tipoindicador_id: 3,
      nombre: 'Mujeres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 5, tipoindicador_id: 3,
      nombre: 'Hombres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 6, tipoindicador_id: 3,
      nombre: 'Sin Sexo de Nacimiento'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 7, tipoindicador_id: 4,
      nombre: 'Mujeres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 8, tipoindicador_id: 4,
      nombre: 'Hombres'
    )
    d.save(validate: false)
    d = Cor1440Gen::Datointermedioti.new(
      id: 9, tipoindicador_id: 4,
      nombre: 'Sin Sexo de Nacimiento'
    )
    d.save(validate: false)
  end

  def down
    Cor1440Gen::Datointermedioti.where('id>=1').where('id<=9').destroy_all
  end
end
