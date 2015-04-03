class RefActoEnActosjr < ActiveRecord::Migration
  def up 
    execute "DROP SEQUENCE IF EXISTS actosjr_seq CASCADE"
    execute "ALTER TABLE actosjr DROP CONSTRAINT IF EXISTS actosjr_pkey CASCADE"
    execute "ALTER TABLE actosjr DROP COLUMN IF EXISTS id"
    execute "ALTER TABLE actosjr ADD CONSTRAINT 
        actosjr_pkey PRIMARY KEY (id_acto)"
  end
  def down
    raise ActiveRecord::IrreversibleMigration    
  end
end
