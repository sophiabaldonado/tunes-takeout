class Music
  attr_reader :name, :type, :links, :image, :embed

  def initialize(spotify)
    # idk
    @name = spotify.name
    @type = spotify.type
    @links = spotify.external_urls
    unless @type == "track"
      @image = spotify.images.find { |img|
        img["height"] == 300
      } #=> returns a hash
      @image = @image["url"] #=> returns an array
    end
    @embed = spotify.uri
  end

  def self.suggested_music(suggestion)
    self.search(suggestion["music_id"], suggestion["music_type"])
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
