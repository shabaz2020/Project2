class PlaylistSong < ApplicationRecord
  belongs_to :song
  belongs_to :playlist

  validates :song_id, uniqueness: { scope: :playlist_id, message: "has already been added to this playlist" }
end
