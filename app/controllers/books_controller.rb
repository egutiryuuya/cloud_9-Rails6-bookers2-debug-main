class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @post_comment = PostComment.new
    @book_favorite=@book.favorites
    
  end

  def index
     to = Time.current.at_beginning_of_day
     from =(to - 6.day).at_end_of_day
    @books = Book.includes(:favorited_users).
    sort{|a,b| 
    b.favorites.where(created_at: from...to).size <=> 
    a.favorites.where(created_at: from...to).size 
    }
    @book = Book.new
    # IPアドレスごとのアクセス数
    # @see = See.find_by(ip: request.remote_ip)
    #   if @see
    #     @views = Book.all
    #   else
    #     @views = Book.all
    #     See.create(ip: request.remote_ip)
    #   end
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user == @book.user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      flash[:alert] = ''
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end
end
