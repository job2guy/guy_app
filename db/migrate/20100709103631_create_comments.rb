class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :body,      :text
      t.references :user, :null => false
      t.timestamps
    end
    execute "alter table comments add constraint fk_user_id
        foreign key (user_id) references users(id)"
  end

  def self.down
    drop_table :comments
  end
end
