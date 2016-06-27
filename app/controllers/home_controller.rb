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
    @comments = Comment.where(receiver_id: @user.id).order("id DESC")
  end

  def send_message                
    post = Post.new(user_id: current_user.id,
                      receiver_id: params[:receiver_id],
                      title: params[:post_title],
                      content: params[:post_content])
    post.save
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
  
  def write_reply
    comment = Comment.new(user_id: current_user.id,
                          receiver_id: params[:receiver_id],
                          content: params[:content])
    comment.save    
    render :json => {:comment_date => comment.created_at.in_time_zone("Seoul").strftime("%Y.%m.%d %H:%M"),
                     :comment_content => comment.content.gsub(/\r\n/, '<br/>').html_safe}
  end
end
