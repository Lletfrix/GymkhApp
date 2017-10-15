class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games
  has_many :challenges
  has_many :challenge_completions
  has_many :completed_challenges, through: :challenge_completions, source: :challenge

  def has_done?(challenge)
    self.completed_challenges.include? challenge
  end

  def game_progress(game)
    self.completed_challenges.where(game: game).count
  end
end
