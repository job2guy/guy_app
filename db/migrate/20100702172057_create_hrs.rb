class CreateHrs < ActiveRecord::Migration
  def self.up
    create_table :hrs do |t|
      t.references :user, :null => false
      t.integer :hr_id ,:null=>false
      t.string :company_name , :null => false
      t.string :website 
      t.boolean :called ,:default=>false
      t.boolean :viewed ,:default=>false
      t.boolean :taken ,:default=>false
      t.timestamps
    end
    execute "alter table hrs add constraint fk_user_id
        foreign key (user_id) references users(id)"
        
    add_index :hrs, :user_id
  end

  def self.down
    drop_table :hrs
  end
end
