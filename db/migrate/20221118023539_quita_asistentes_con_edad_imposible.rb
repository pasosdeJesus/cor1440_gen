class QuitaAsistentesConEdadImposible < ActiveRecord::Migration[7.0]
  def up
    res = execute <<-SQL
    SELECT * FROM (SELECT asi.id, asi.actividad_id, asi.persona_id,
      sip_edad_de_fechanac_fecharef(p.anionac, p.mesnac, p.dianac,
      extract(year FROM a.fecha)::integer, extract(month FROM a.fecha)::integer,
      extract(day FROM a.fecha)::integer) AS edad,
      a.fecha as actividad_fecha,
      p.anionac, p.mesnac, p.dianac
      FROM cor1440_gen_asistencia AS asi
      JOIN cor1440_gen_actividad AS a ON a.id=asi.actividad_id
      JOIN sip_persona AS p on p.id=asi.persona_id) AS sub
    WHERE sub.edad<0 OR sub.edad>119;
    SQL
    if res.count > 0
      puts "En base se encontraron #{res.count} asistentes nacidos después "\
        " de la actividad o con edades mayores a 120 en la actividad. "\
        " Se retiran de los listados de asistencia: "
      res.each do |r|
        puts "- De la actividad #{r['actividad_id']} "\
          "con fecha #{r['actividad_fecha']} "\
          "se retira persona #{r['persona_id']} nacida el "\
          "#{r['anionac']}-#{r['mesnac']}-#{r['dianac']} porque "\
          "tendría #{r['edad']} años"
        Cor1440Gen::Asistencia.find(r['id']).destroy
      end
    end
  end

  def down
  end
end
