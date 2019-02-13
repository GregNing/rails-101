class PostsController < ApplicationController
  before_action :find_post, only: %i[edit update destroy]
  before_action :find_group

  def new
    @post = @group.posts.build
  end

  def edit
    @post = Post.find(params[:id])
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
    @post = @group.posts.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end
end
