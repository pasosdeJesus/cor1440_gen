class MejoraTipoindicadorIntermedios < ActiveRecord::Migration[6.0]
  def up
    add_column :cor1440_gen_tipoindicador, :descd1, :string, limit: 32
    add_column :cor1440_gen_tipoindicador, :descd2, :string, limit: 32
    add_column :cor1440_gen_tipoindicador, :descd3, :string, limit: 32
    add_column :cor1440_gen_tipoindicador, :descd4, :string, limit: 32
    Cor1440Gen::Tipoindicador.create!(
      id: 4,
      nombre: 'CUENTA ASIST. ÚNICOS ACT',
      espfuncionmedir: 'Un participante que esté en listado de dos actividades diferentes cuenta una sóla vez',
      medircon: 1,
      descd1: 'Hombres únicos',
      descd2: 'Mujeres únicas',
      descd3: 'Sin Sexo de Nacimiento únicos',
      descd4: '',
      fechacreacion: '2020-03-30',
      created_at: '2020-03-30',
      updated_at: '2020-03-30'
    )
    execute <<-SQL
      UPDATE cor1440_gen_tipoindicador SET medircon=1 WHERE id>=1 AND id<=3;
    SQL
    t = Cor1440Gen::Tipoindicador.find(2)
    t.descd1 = 'Hombres'
    t.descd2 = 'Mujeres'
    t.descd3 = 'Sin Sexo de Nacimiento'
    t.save!

    t = Cor1440Gen::Tipoindicador.find(3)
    t.descd1 = 'Hombres'
    t.descd2 = 'Mujeres'
    t.descd3 = 'Sin Sexo de Nacimiento'
    t.save!
  end

  def down
    remove_column :cor1440_gen_tipoindicador, :descd1
    remove_column :cor1440_gen_tipoindicador, :descd2
    remove_column :cor1440_gen_tipoindicador, :descd3
    remove_column :cor1440_gen_tipoindicador, :descd4
    t = Cor1440Gen::Tipoindicador.find(4).destroy
  end

end
