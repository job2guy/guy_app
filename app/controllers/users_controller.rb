class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.new
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please wait for your account activation we will send confirmation mail to #{@user.email}!"
      redirect_to root_url
    else
      render :action => :new
    end
  rescue Exception => e
    
    end
  end

  def show
    @user = @current_user
    if params[:flag] and !params[:flag].empty?
      if params[:flag]=="admin"
        @url_path= '/admins'
      elsif params[:flag]=="common"
        @url_path= '/member_details'
      elsif params[:flag]=="hr"
        @url_path= '/hrs'
      end
    end
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_profile(params)
    #if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      if params[:flag] and !params[:flag].empty?
        if params[:flag]=="admin"
          redirect_to :controller=>"admins"
        elsif params[:flag]=="common"
          redirect_to :controller=>"member_details"
        elsif params[:flag]=="hr"
          redirect_to :controller=>"hrs"
        end
       end
    else
      render :action => :edit,:flag=>params[:flag]
    end
  end

  def destroy
    @user = @current_user
    #@user.destroy
    @user.update_attribute(:active=>false)
    flash[:notice] = "Account deleted!"
    redirect_to '/'
  end
  
end