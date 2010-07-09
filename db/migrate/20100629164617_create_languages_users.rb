class CreateLanguagesUsers < ActiveRecord::Migration
  def self.up
      create_table :languages_users do |t|
      t.references :user, :null => false
      t.references :language, :null => false
      t.timestamps
    end
    execute "alter table languages_users add constraint fk_language_id
        foreign key (language_id) references languages(id)"
    execute "alter table languages_users add constraint fk_user_id
        foreign key (user_id) references users(id)"
  end

  def self.down
    drop_table :languages_users
  end
end
