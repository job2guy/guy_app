class User < ActiveRecord::Base
  validates_presence_of :name, :mobile, :message=>"can't be blank!"
  validates_numericality_of :mobile, :message => "is not integer!"
  validates_length_of :mobile, :in => 10..13, :message => "is not valid!"
  validates_uniqueness_of :mobile
  has_many :comments
  has_many :roles_users
  has_many :languages_users
  has_one :member_detail
  has_one :role ,:through=>:roles_users
  has_one :language ,:through=>:languages_users
  attr_accessible :login, :email, :password, :password_confirmation
  #acts_as_authentic
   acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end
  
  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end

  
  def has_no_credentials?
    !self.crypted_password.blank? || !password.blank?
  end
  
  def signup!(params)
    self.name = params[:user][:name]
    self.login = params[:user][:login]
    self.mobile = params[:user][:mobile]
    self.email = params[:user][:email]
    save_without_session_maintenance
  end
  
  def active?
    active
  end

  def activates!
    self.active = true
    save
  end
  def update_profile(params)
    self.name = params[:user][:name]
    self.login = params[:user][:login]
    self.mobile = params[:user][:mobile]
    self.email = params[:user][:email]
    activate!(params)
  end
  def activate!(params)
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
 
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
  def deliver_password_reset_instructions!  
      reset_perishable_token!  
      Notifier.deliver_password_reset_instructions(self)  
  end  
end
