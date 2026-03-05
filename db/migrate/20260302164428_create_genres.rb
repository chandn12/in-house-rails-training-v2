class CreateGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
