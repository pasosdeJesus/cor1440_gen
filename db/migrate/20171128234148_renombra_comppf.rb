class RenombraComppf < ActiveRecord::Migration[5.1]
  def change
    rename_table :actividadpf, :cor1440_gen_actividadpf
    rename_table :actividad_actividadpf, :cor1440_gen_actividad_actividadpf
    rename_table :objetivopf, :cor1440_gen_objetivopf
    rename_table :resultadopf, :cor1440_gen_resultadopf
    rename_table :indicadorpf, :cor1440_gen_indicadorpf
  end
end
