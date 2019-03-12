class CreaPmindicadorpf < ActiveRecord::Migration[5.2]
  def up
    if !table_exists? :cor1440_gen_pmindicadorpf
      create_table :cor1440_gen_pmindicadorpf do |t|
        t.integer :mindicadorpf_id, null: false
        t.date  :finicio
        t.date  :ffin
        t.string :restiempo, limit: 128
        t.float :dmed1
        t.float :dmed2
        t.float :dmed3
        t.json :datosmedicion
        t.float :rind
        t.float :meta
        t.json :resindicador
        t.float :porcump
        t.string :analisis, limit: 4096
        t.string :acciones, limit: 4096
        t.string :responsables, limit: 4096
        t.string :plazo, limit: 4096
        t.date  :fecha
        t.string :urlev1, limit: 4096
        t.string :urlev2, limit: 4096
        t.string :urlev3, limit: 4096
        t.string :urlevrind, limit: 4096
        t.timestamp :created_at, null: false
        t.timestamp :updated_at, null: false
      end
      add_foreign_key :cor1440_gen_pmindicadorpf,  
        :cor1440_gen_mindicadorpf,  column: :mindicadorpf_id
    end
  end

  def down
    drop_table :cor1440_gen_pmindicadorpf  
  end
end
