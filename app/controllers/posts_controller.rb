class PostsController < ApplicationController
  before_action :login_required, expect: %i[index show]
  before_action :find_post, only: %i[edit update destroy]
  before_action :find_group
  before_action :member_required, only: %i[new create]

  def new
    @post = @group.posts.build
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def create
    @post = @group.posts.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to group_path(@group)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def member_required
    unless current_user.is_member_of?(@group)
      flash[:warning] = 'You are not member of this group!'
      redirect_to group_path(@group)
    end
  end
end
