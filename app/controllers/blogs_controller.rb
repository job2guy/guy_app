require 'rubygems'
class BlogsController < ApplicationController
   layout "common"
  def comment
    if User.find(current_user.id).comments.create(params[:comment])
       flash[:notice] = "Added your comment"
    else
      flash[:notice] = "Comment not added"
    end
  end
  def show
   render :layout =>false
  end
end
