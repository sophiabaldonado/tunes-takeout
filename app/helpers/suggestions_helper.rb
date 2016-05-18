require 'rspotify'
module SuggestionsHelper

  def suggested_music(id, music_type)

    case music_type
    when "artist"
      @music = RSpotify::Artist.find(id)
    when "album"
      @music = RSpotify::Album.find(id)
    when "playlist"
      @music = RSpotify::Playlist.find(id)
    when "track"
      @music = RSpotify::Track.find(id)
    else
      @music = nil
    end
      @music
  end
end
