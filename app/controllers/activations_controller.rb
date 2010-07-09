class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end
 
    def create
     @user=User.find(params[:id])
      if params[:flag] and !params[:flag].empty? and params[:flag]=="confirm"
        if params[:commit] and params[:commit]=="Submit"
            if @user.activate!(params)
              if params[:language] and params[:language][:id]!=nil
                languages_user=LanguagesUser.new
                if languages_user.update_attributes(:user_id=>@user.id,:language_id=>params[:language][:id])
                  flash[:notice] = "Successfully created! Please login to access your page."
                  redirect_to root_url
                end
              end
            else
              render :action => :create
            end
        end
      else
        raise Exception if @user.active?
          if @user.activates!
            @user.deliver_activation_confirmation!
            if params[:role] and params[:role][:id]!=nil
              roles_user=RolesUser.new
              if roles_user.update_attributes(:user_id=>@user.id,:role_id=>params[:role][:id])
                flash[:notice] = "#{@user.name} account has been activated."
                redirect_to root_url
              end
            end
          else
            render :action => :new
          end
      end
    end    
end
