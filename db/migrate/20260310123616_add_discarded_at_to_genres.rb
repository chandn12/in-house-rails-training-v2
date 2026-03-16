class AddDiscardedAtToGenres < ActiveRecord::Migration[8.1]
  def change
    add_column :genres, :discarded_at, :datetime
    add_index :genres, :discarded_at
  end
end
