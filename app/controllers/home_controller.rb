class HomeController < ApplicationController
  def index
  # @users = User.where.not(id: current_user.id)    
  end

  def appeal
    @users = User.where.not(id: current_user.id)
  end

  def my_page   
    @user = current_user
    @posts = Post.where(receiver_id: current_user.id).order("id DESC")
  end

  def send_message                
    # @post = Post.create(user_id: current_user.id,
    #                   receiver_id: params[:receiver_id],
    #                   title: params[:post_title],
    #                   content: params[:post_content])
    # render :json => {
    #                 :receiver_id => User.find(params[:receiver_id]).id,
    #                 :p => @post
    #                 }     
    post = Post.create(user_id: current_user.id,
                      receiver_id: params[:receiver_id],
                      title: params[:title],
                      content: params[:content])
                      
    redirect_to "/appeal"    
  end
end
