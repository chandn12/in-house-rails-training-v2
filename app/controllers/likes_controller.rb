class LikesController < ApplicationController
  before_action :set_book

  def create
    @book.likes.create(user: current_user)
    redirect_back(fallback_location: books_path)
  end

  def destroy
    like = @book.likes.find_by(user: current_user)
    like&.destroy
    redirect_back(fallback_location: books_path)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
