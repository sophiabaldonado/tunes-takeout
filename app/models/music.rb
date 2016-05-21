require 'rspotify'

class Music
  attr_reader :name, :type, :links, :image, :embed

  def initialize(spotify)
    @name = spotify.name
    @type = spotify.type
    @links = spotify.external_urls
    unless @type == "track" || spotify.images.empty?
      @image = spotify.images[1]["url"]
    end
    @embed = spotify.uri
  end

  def self.suggested_music(suggestion)
    self.search(suggestion["music_id"], suggestion["music_type"])
  end

  def self.search(id, music_type)
    music = case music_type
    when "artist"
      RSpotify::Artist.find(id)
    when "album"
      RSpotify::Album.find(id)
    when "track"
      RSpotify::Track.find(id)
    else
      nil
    end

    self.new(music)
  end
end
