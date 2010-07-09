class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    t.string    :name,:null => false, :limit => 50
    t.string    :mobile, :limit => 15,:null => false
    t.string    :login, :default => nil, :null => true                # optional, you can use email instead, or both
    t.string    :email, :null => false                # optional, you can use login instead, or both
    t.string    :crypted_password, :default => nil, :null => true                # optional, see below
    t.string    :password_salt, :default => nil, :null => true                # optional, but highly recommended
    t.string    :persistence_token, :null => false               # required
    t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
    t.string    :perishable_token, :null => false    
    t.boolean    :active,             :default => false, :null => false

    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
    t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
    t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
    t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
    t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
    t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
    t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
    t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
    t.timestamps
  end
    add_index :users, :login
    add_index :users, :email
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end

  def self.down
    drop_table :users
  end
end