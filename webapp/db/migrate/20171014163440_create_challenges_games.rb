class CreateChallengesGames < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges_games do |t|
      t.references :challenge, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
