class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, :through => :user_games

  validates :name, uniqueness: true
end