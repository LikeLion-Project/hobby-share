class HomeController < ApplicationController
  def index
# @users = User.where.not(id: current_user.id)
 @user = current_user
  end

  def appeal
    @users = User.where.not(id: current_user.id)
  end

  def my_page
    @user = current_user
    @posts = Post.where(user_id: current_user.id).order("id DESC")
  end

  def send_message
    Post.create(user_id: params[:target_user_id],
                sender: params[:user_id],
                title: params[:title],
                content: params[:content])
    redirect_to "/appeal"
  end
end
