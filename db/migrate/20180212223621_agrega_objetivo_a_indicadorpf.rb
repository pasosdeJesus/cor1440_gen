class AgregaObjetivoAIndicadorpf < ActiveRecord::Migration[5.2]
  def change
    add_column :cor1440_gen_indicadorpf, :objetivopf_id, :integer
    add_foreign_key :cor1440_gen_indicadorpf, :cor1440_gen_objetivopf, 
      column: :objetivopf_id
  end
end
