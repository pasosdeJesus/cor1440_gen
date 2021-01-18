class AjustaListadoActividades < ActiveRecord::Migration[6.0]
  def up
    ca = Cor1440Gen::ActividadesController.new
    if !ca.atributos_form.map(&:to_s).include?('observaciones')
      execute <<-SQL
        DELETE FROM heb412_gen_campoplantillahcm WHERE id=514;
        UPDATE heb412_gen_campoplantillahcm SET
          columna='O' WHERE id=515;
        UPDATE heb412_gen_campoplantillahcm SET
          columna='P' WHERE id=516;
      SQL
    end
  end

  def down
    if Heb412Gen::Campoplantillahcm.where(id: 514).count == 0
      execute <<-SQL
        UPDATE heb412_gen_campoplantillahcm SET
          columna='Q' WHERE id=516;
        UPDATE heb412_gen_campoplantillahcm SET
          columna='P' WHERE id=515;
        INSERT INTO heb412_gen_campoplantillahcm 
          (id, plantillahcm_id, nombrecampo, columna) VALUES
          (514, 5, 'observaciones', 'O');
      SQL
    end
  end
end
