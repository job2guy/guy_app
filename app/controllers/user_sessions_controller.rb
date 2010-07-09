class UserSessionsController < ApplicationController
layout "login"
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      role_user=RolesUser.find_by_user_id(current_user.id)
      if role_user.role.name=="admin"
        redirect_to :controller=>"admins"
      elsif role_user.role.name=="hr"
        redirect_to :controller=>"hrs"
      elsif role_user.role.name=="friend"
        redirect_to :controller=>"member_details"
      elsif role_user.role.name=="relative"
        redirect_to :controller=>"member_details"
      elsif role_user.role.name=="member"
        redirect_to :controller=>"member_details"
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end
end
