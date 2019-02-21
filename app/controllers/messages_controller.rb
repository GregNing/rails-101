class MessagesController < ApplicationController
  before_action :find_post

  def create
    @message = @post.messages.new(message_params)
    @message.user = current_user
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
