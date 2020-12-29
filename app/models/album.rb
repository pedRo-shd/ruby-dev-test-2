class Album < ApplicationRecord
  belongs_to :player, required: false
  has_many :player_albums
  has_many :players, through: :player_albums

  validates_presence_of :name
end
