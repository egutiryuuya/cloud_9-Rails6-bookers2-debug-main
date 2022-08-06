class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    post_comment = PostComment.find(params[:book_id])
    post_comment.destroy
    redirect_to book_path
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
