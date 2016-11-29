class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @opinions = @book.opinions.all
    if user_signed_in?
      @opinion = Opinion.new
    end
  end
end
