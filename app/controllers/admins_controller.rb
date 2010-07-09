require 'rubygems'
require 'will_paginate'
class AdminsController < ApplicationController
  before_filter :require_user
  layout "admin"
  @@per_page = 6
  def index
  end
  
  def active_users
    #@users=User.find(:all,:conditions=>["active=?",true])
    @users=User.paginate :all,:conditions=>["active=?",true],:order=>"name",:page => params[:page], :per_page => @@per_page
    @sno=1
    @sno=(@@per_page.to_i*params[:page].to_i)-(@@per_page.to_i-1) if params[:page] and params[:page]!=""
  end
  
  def inactive_users
    #@users=User.find(:all,:conditions=>["active=?",false])
    @sno=1
    @sno=(@@per_page.to_i*params[:page].to_i)-(@@per_page.to_i-1) if params[:page] and params[:page]!=""
    @users=User.paginate :all,:conditions=>["active=?",false],:order=>"name",:page => params[:page], :per_page => @@per_page
  end
  
  def status
     @user=User.find(params[:id])
    if params[:flag] and !params[:flag].empty?
      if params[:flag]=='true'
        action_str="inactive_users"
        flash[:notice]= "Successfully ".to_s + @user.name.to_s + " activated "
      else
        action_str="active_users"
        flash[:notice]= "Successfully ".to_s + @user.name.to_s + " deactivated " 
      end
      if @user.update_attribute(:active,params[:flag])
        redirect_to :controller=>"admins" ,:action=>action_str
      end
    end
  end
  def list_view
    @sno=1
    @sno=(@@per_page.to_i*params[:page].to_i)-(@@per_page.to_i-1) if params[:page] and params[:page]!=""
    if params[:flag] and !params[:flag].empty?
      @role=Role.find_by_name(params[:flag])
      @roleusers=RolesUser.find_all_by_role_id(@role.id)
      if @roleusers and @roleusers.length>0
        id_array=[]
        @roleusers.each do |user|
          id_array << user.user_id
        end
        user_id = id_array * ","
         @users=User.paginate :all,:conditions=>["active=? and id in(#{user_id})",true],:order=>"name",:page => params[:page], :per_page => @@per_page
      end
    end
  end
  
  def send_mail
    @to=params[:mail]
    @sub="Hello " + params[:name].capitalize
    render :layout=>false
  end
  def post
    emailsender(params[:from],params[:to],params[:sub],params[:message])
    flash[:notice] ="Successfully send"
    redirect_to :list_view ,:flag=>params[:flag]
  end
  
  def comment
    @users=User.find(:all,:conditions=>["active=true"])
  end
end
