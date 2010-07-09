class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users do |t|
      t.references :user, :null => false
      t.references :role, :null => false
      t.timestamps
    end
    execute "alter table roles_users add constraint fk_role_id
        foreign key (role_id) references roles(id)"
    execute "alter table roles_users add constraint fk_user_id
        foreign key (user_id) references users(id)"
  end

  def self.down
    drop_table :roles_users
  end
end
