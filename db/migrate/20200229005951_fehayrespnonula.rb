class Fehayrespnonula < ActiveRecord::Migration[6.0]
  def up

    execute <<-SQL
      UPDATE cor1440_gen_actividad SET fecha='2020-12-31' where fecha IS NULL;
    SQL
    if Usuario.all.count > 0
      primus = Usuario.all.order(:id)[0].id
      execute <<-SQL
      UPDATE cor1440_gen_actividad SET usuario_id=#{primus} where usuario_id IS NULL;
      SQL
    end
    change_column_null :cor1440_gen_actividad, :fecha, false
    change_column_null :cor1440_gen_actividad, :usuario_id, false
  end
  def down
    change_column_null :cor1440_gen_actividad, :fecha, true
    change_column_null :cor1440_gen_actividad, :usuario_id, true
  end
end
