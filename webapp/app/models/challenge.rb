class Challenge < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game

  has_many :challenge_completions
  has_many :users, through: :challenge_completions

  before_save :set_place

  def set_place
    p = self.foursquare_id.split(';')
    self.foursquare_id = p[0]
    self.place_name = p[1]
  end
end
