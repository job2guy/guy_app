require 'rubygems'
class BlogsController < ApplicationController
   layout "common"
  def comment
    @user=User.find(current_user.id)
    params[:comment][:body]=params[:comment][:body].split(/\r\n/).join(' ').squeeze(' ').strip
    if @user.comments.create(params[:comment])
       flash[:notice] = "Added your comment"
    else
      flash[:notice] = "Comment not added"
    end
  end
  def show
   render :layout =>false
  end
end
