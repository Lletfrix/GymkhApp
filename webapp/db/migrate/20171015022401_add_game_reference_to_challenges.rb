class AddGameReferenceToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_reference :challenges, :game, foreign_key: true
  end
end
