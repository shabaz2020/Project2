User.destroy_all
Playlist.destroy_all
Artist.destroy_all
Album.destroy_all
Track.destroy_all
AddSong.destroy_all

20.times do
User.create(name: Faker::Name.name)
end

20.times do 
Playlist.create(title: Faker::Beer.brand, user_id: User.all.sample.id)
end 


20.times do
Artist.create(name: Faker::Music.band, bio: Faker::Lorem.paragraph)
end

20.times do
    1.times do 
        artist = Artist.all.sample.id
        Album.create(title: Faker::Music.album, artist_id: artist)
        Album.create(title: Faker::Music.album, artist_id: artist)
        Album.create(title: Faker::Music.album, artist_id: artist)
    end
end
 
20.times do 
    1.times do
        album = Album.all.sample.id
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
        Track.create(name: Faker::Creature::Cat.name, album_id: album)
    end
end 

20.times do 
    1.times do
        playlist = Playlist.all.sample.id
        AddSong.create(playlist_id: playlist , track_id: Track.all.sample.id)
        AddSong.create(playlist_id: playlist , track_id: Track.all.sample.id)
        AddSong.create(playlist_id: playlist , track_id: Track.all.sample.id)
        AddSong.create(playlist_id: playlist , track_id: Track.all.sample.id)
        AddSong.create(playlist_id: playlist , track_id: Track.all.sample.id)
    end
end 