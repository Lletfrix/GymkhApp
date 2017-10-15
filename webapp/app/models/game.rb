class Game < ApplicationRecord
  belongs_to :user
  has_many :challenges

  accepts_nested_attributes_for :challenges

  before_save :enforce_slug

  def enforce_slug
    self.slug ||= SecureRandom.base64(5)

    while (Game.where(slug: self.slug).count > 1)
      self.slug = SecureRandom.base64(5)
    end
  end

  def pending_challenges(user)
    self.challenges.to_a.reject do |c|
      user.has_done? c
    end
  end
end
