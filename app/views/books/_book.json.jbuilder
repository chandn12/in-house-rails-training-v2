json.extract! book, :id, :name, :short_description, :user_id, :genre_id, :created_at, :updated_at
json.url book_url(book, format: :json)
