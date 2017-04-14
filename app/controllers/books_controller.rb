class BooksController < ApplicationController
  def index
    books = Book.all.map do |book|
      book_presenter = BookPresenter.new(book, params)
      FieldPicker.new(book_presenter).pick
    end

    render json: { data: books }.to_json
  end
end
