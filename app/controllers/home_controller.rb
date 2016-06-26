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
  
  def detail_page
    @user = User.find(params[:id])
  end

  def send_message                
    post = Post.create(user_id: current_user.id,
                      receiver_id: params[:receiver_id],
                      title: params[:post_title],
                      content: params[:post_content])
    render :json => {
                    :receiver_email => User.find(params[:receiver_id]).email,
                    :p => post
                    }     
    # post = Post.create(user_id: current_user.id,
    #                   receiver_id: params[:receiver_id],
    #                   title: params[:title],
    #                   content: params[:content])
                      
    # redirect_to "/appeal", :flash => { :success => "메시지가 전송되었습니다." }
  end
end
