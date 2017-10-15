class AddPlaceNameToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :place_name, :string
  end
end
