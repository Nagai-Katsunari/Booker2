class BooksController < ApplicationController  
  before_action :authenticate_user!

  def index
    @books=Book.page(params[:page])
    @user=User.find(current_user.id)
    @book=Book.new
    
  end

  def new
    @book=Book.new
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      
      render :new
      
    end
  end

  def show
    @book=Book.find(params[:id])
    
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def destroy
    book = Book.find(params[:id]) #データ(レコード)を1件取得
    book.destroy #データ（レコード）を削除
    redirect_to books_path #List一覧画面へリダイレクト
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end



  private
    def books_params
      params.require(:book).permit(:title, :body, :user_id)
    end
end

