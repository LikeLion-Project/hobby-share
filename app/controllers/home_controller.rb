class HomeController < ApplicationController
  def index
  # @users = User.where.not(id: current_user.id)    
  end

  # 카드 목록 화면
  def appeal
    @users = User.where.not(id: current_user.id)
  end

  # 메시지 화면
  def my_page   
    @user = current_user
    @posts = Post.where(receiver_id: current_user.id).order("id DESC")
  end
  
  # 상세 화면
  def detail_page
    @user = User.find(params[:id])
    @comments = Comment.where(receiver_id: @user.id).order("id DESC")
    
    like = Like.where(user_id: current_user.id , receiver_id: params[:id]).take
    if like.nil?
      @like_flag = false
    else
      @like_flag = true
    end   
  end

  # 메시지 전달 요청 action
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
  
  # 댓글 작성 요청 action
  def write_reply
    comment = Comment.new(user_id: current_user.id,
                          receiver_id: params[:receiver_id],
                          content: params[:content])
    comment.save    
    render :json => {:comment_date => comment.created_at.in_time_zone("Seoul").strftime("%Y.%m.%d %H:%M"),
                     :comment_content => comment.content.gsub(/\r\n/, '<br/>').html_safe}
  end
  
  # 좋아요 요청 action
  def like_user
    like = Like.where(user_id: current_user , receiver_id: params[:receiver_id]).take
    user = User.find(params[:receiver_id])
    if like.nil?
      like = Like.new(user_id: current_user.id,
                receiver_id: params[:receiver_id])
      like.save
      like_flag = true
      user.like_count += 1
      
    else
      Like.destroy(like.id)
      like_flag = false
      user.like_count -= 1
    end
      user.save
      render :json => {
                    :like_flag => like_flag,
                    :like_count => user.like_count
                    }     
  end
  
  # 좋아요 취소 요청 action
  # def unlike_user
  #   like = Like.where(user_id: current_user , receiver_id: params[:receiver_id]).take
  #   if !like.nil?
  #     Like.destroy(like.id)
  #   end
  #   current_user.count -= 1
  #   current_user.save
  # end
end
