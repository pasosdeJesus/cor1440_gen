class Indicadordeobjetivooderesultado < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      ALTER TABLE cor1440_gen_indicadorpf 
        ADD CONSTRAINT objetivo_xor_resultado CHECK (
          (objetivopf_id IS NOT NULL OR resultadopf_id IS NOT NULL) AND
          (objetivopf_id IS NULL OR resultadopf_id IS NULL)
        );
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE cor1440_gen_indicadorpf 
        DROP CONSTRAINT objetivo_xor_resultado;
    SQL
  end
end
