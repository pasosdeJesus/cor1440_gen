class HomologaFormularioActividadpf < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      UPDATE cor1440_gen_actividadpf SET
        formulario_id = atf.formulario_id FROM cor1440_gen_actividadtipo AS at 
        JOIN cor1440_gen_actividadtipo_formulario AS atf 
        ON at.id=atf.actividadtipo_id WHERE 
        cor1440_gen_actividadpf.actividadtipo_id=at.id;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE cor1440_gen_actividadpf SET
        formulario_id = NULL FROM cor1440_gen_actividadtipo AS at 
        JOIN cor1440_gen_actividadtipo_formulario AS atf 
        ON at.id=atf.actividadtipo_id WHERE 
        cor1440_gen_actividadpf.actividadtipo_id=at.id;
    SQL
  end
end
