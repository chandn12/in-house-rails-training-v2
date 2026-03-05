class RemoveGenreIdFromBooks < ActiveRecord::Migration[8.1]
  def change
    remove_reference :books, :genre, null: false, foreign_key: true
  end
end
