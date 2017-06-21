class Game < ApplicationRecord
  
  has_many :purchases
  
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
  
  def self.search(query)
    where('title like ?', "%#{query}%")
  end
  
  def user_purchased?(user_id)
    purchase = Purchase.where(:user_id => user_id, :game_id => self.id).first
    if purchase
      true
    else
      false
    end
  end
  
  def purchase_game(user_id)
    purchase = Purchase.where(:user_id => user_id, :game_id => self.id).first
    if purchase
      purchase.delete
    else
      purchase = Purchase.new(:user_id => user_id, :game_id => self.id)
      purchase.save
    end
  end
end
