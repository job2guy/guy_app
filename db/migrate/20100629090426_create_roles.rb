class CreateRoles < ActiveRecord::Migration
  def self.up
    
    create_table :roles do |t|
      t.string :name, :null => false
      t.string :title, :null => false
      t.timestamps
    end
    
    Role.find_or_create_by_name(:name => 'admin',:title=>'Administrator')
    Role.find_or_create_by_name(:name => 'friend',:title=>'Friend')
    Role.find_or_create_by_name(:name => 'hr',:title=>'Human resources')
    Role.find_or_create_by_name(:name => 'relative',:title=>'Relative')
    Role.find_or_create_by_name(:name => 'member',:title=>'Member')
    puts "Roles (admin, friend, hr, relative,memeber) created."
    
  end

  def self.down
    drop_table :roles
  end
end
