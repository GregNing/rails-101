class GroupsController < ApplicationController
  before_action :find_group_by_user, only: %i[edit update destroy]
  before_action :find_group, only: %i[show join quit]

  def index
    @groups = Group.all
  end

  def show
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def join
    if current_user.is_member_of?(@group)
      flash[:warning] = 'You are already in the group!'
    else
      current_user.join!(@group)
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    else
      flash[:warning] = 'You are not the member of the group!'
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_by_user
    @group = current_user.groups.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:id])
  end
end
