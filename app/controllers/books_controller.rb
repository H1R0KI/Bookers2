class BooksController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @user = User.find(current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path(@book.id)
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
