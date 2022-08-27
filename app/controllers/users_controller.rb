class UsersController < ApplicationController
  before_action :ensure_correct_user, only: %i[update edit]

  def show
    
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @yesterday2 =@books.created_yesterday2
    @yesterday3 =@books.created_yesterday3
    @yesterday4 =@books.created_yesterday4
    @yesterday5 =@books.created_yesterday5
    @yesterday6 =@books.created_yesterday6
    
    @this_week = @books.created_thisweek
    @last_week =@books.created_lastweek
    
  end

  def index
    @user =current_user
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}", notice: 'You have updated user successfully.'
    else
      render 'edit'
    end
  end
  
  def followings
    user = User.find(params[:id])
    @users =user.followings
    
  end
  
  def followers
    user=User.find(params[:id])
    @users=user.followers
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end
