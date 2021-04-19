class TindicadorCuentaOrganizaciones < ActiveRecord::Migration[6.1]
  def up
    Cor1440Gen::Tipoindicador.create!(
      id: 5,
      nombre: 'CUENTA ORGANIZACIONES',
      espfuncionmedir: 'Participaciones de organizaciones en actividades',
      medircon: 1,
      fechacreacion: '2021-04-17',
      created_at: '2021-04-17',
      updated_at: '2021-04-17'
    )
    Cor1440Gen::Tipoindicador.create!(
      id: 6,
      nombre: 'CUENTA ORGANIZACIONES ÚNICAS',
      espfuncionmedir: 'Cantidad de organizaciones diferentes en las actividades',
      medircon: 1,
      fechacreacion: '2021-04-17',
      created_at: '2021-04-17',
      updated_at: '2021-04-17'
    )
  end
  def down
    Cor1440Gen::Tipoindicador.find(6).destroy
    Cor1440Gen::Tipoindicador.find(5).destroy
  end
end
