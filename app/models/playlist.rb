class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: {scope: :user}

  def self.find_by_query(query_term)
    self.where("name LIKE ?", "%#{query_term}%")
  end

end
