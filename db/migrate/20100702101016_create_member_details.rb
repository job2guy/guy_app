class CreateMemberDetails < ActiveRecord::Migration
  def self.up
    create_table :member_details do |t|
       t.references :user, :null => false
       t.date :dob
       t.integer :age ,:limit=>2
       t.boolean :gender,:default=>true # true for male
       t.string :qualification, :null => false
       t.text :address, :null => false
       t.string :relationship,:default=>"friend"
       t.boolean :job_status,:default=>false # need-job=>true not-need=>false
       t.text :resume
       t.boolean :work_status,:default=>false # fresher=>false exp =>true
       t.text :lang_experiance
       t.string :company_name
      t.timestamps
    end
    execute "alter table member_details add constraint fk_user_id
        foreign key (user_id) references users(id)"
    add_index :member_details, :job_status
    add_index :member_details, :work_status
    add_index :member_details, :user_id
  end

  def self.down
    drop_table :member_details
  end
end