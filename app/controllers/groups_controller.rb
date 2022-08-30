class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]
  before_action :authenticate_user!
  
  def index
    @group_lists = Group.all
    @group_jointing = GroupUser.where(user_id: current_user.id)
    @group_lists_none ="グループに参加していません"
    @user = current_user
  end
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end
  
  def show
    @group = Group.find(params[:id])
    @user = current_user
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end
  
  def destroy
    delete_group = Group.find(params[:id])
    if delete_group.destroy
      redirect_to groups_path, notice: 'グループを削除しました'
    end
  end
  
  
  private
  
  def set_group
    @group = Group.find(params[:id])
    unless @group.owner_id ==current_user.id
      redirect_to groups_path
    end
  end
  
  def group_params
    params.require(:group).permit(:name, :introduction,:image)
  
  end
end
