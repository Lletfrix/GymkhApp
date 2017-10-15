class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.string :foursquare_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
