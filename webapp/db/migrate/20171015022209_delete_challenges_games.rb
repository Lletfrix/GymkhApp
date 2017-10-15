class DeleteChallengesGames < ActiveRecord::Migration[5.1]
  def change
    drop_table :challenges_games
  end
end
