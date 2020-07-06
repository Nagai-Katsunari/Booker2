class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book=Book.new
  end
  def new
    @book=Book.new
  end
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end
  
  
  
  def index
    @book=Book.new
    @users=User.all
    @user=User.find(current_user.id)
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user)
    else
      flash[:notice] = "error"
      render 'edit'
    end
  end
  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

 
end
