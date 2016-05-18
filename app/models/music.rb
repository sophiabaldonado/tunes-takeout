class Music
  attr_reader :name, :type, :links, :image

  def initialize(spotify_object)
    # idk
    @name = spotify_object.name
    @type = spotify_object.type
    @links = spotify_object.external_urls
    unless @type == "track"
      @image = spotify_object.images.find { |img|
        img["height"] == 300
      } #=> returns a hash
      @image = @image["url"]
    end


  end

  def self.suggested_music(suggestions)
    suggestions.map { |suggestion|
      self.search(suggestion["music_id"], suggestion["music_type"])
    }
  end


  def self.search(id, music_type)
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
      self.new(@music)
  end

end
