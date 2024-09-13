class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :cover_url
      t.text :summary
      t.integer :year
      t.integer :duration
      t.date :suggested_date
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
