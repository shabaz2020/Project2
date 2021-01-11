class Song < ApplicationRecord
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  def self.find_by_query(query_term)
    self.where("title LIKE ?", "%#{query_term}%")
  end
end
