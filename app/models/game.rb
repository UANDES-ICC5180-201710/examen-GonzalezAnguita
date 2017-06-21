class Game < ApplicationRecord
  
  validates :title, {
    presence: true,
    length: {minimum: 10, maximum: 30},
    uniqueness: true
  }
  validates :description, {
    presence: true,
    length: {minimum: 10}
  }
  validates :image_url, {
    presence: true
  }
end
