require 'rspotify'

class Music
  attr_reader :name, :type, :links, :image, :embed

  # def initialize(spotify)
  #   @name = spotify.name
  #   @type = spotify.type
  #   @links = spotify.external_urls
  #   unless @type == "track" || spotify.images.empty?
  #     @image = spotify.images[1]["url"]
  #   end
  #   @embed = spotify.uri
  # end

  # fake music object for styling
  def initialize(spotify)
    @name = "Deeply Disturbed"
    @type = "album"
    @links = {"spotify"=>"https://open.spotify.com/album/2BYEP9y3BNpbi1ueR3Bdmc"}
    # unless @type == "track" || spotify.images.empty?
      @image = "https://i.scdn.co/image/32f16048f6ae3269ff0875c53e843ea40e52fa77"
    # end
    @embed = "spotify:album:2BYEP9y3BNpbi1ueR3Bdmc"
  end

  def self.suggested_music(suggestion)
    self.search(suggestion["music_id"], suggestion["music_type"])
  end

  def self.search(id, music_type)
  #   music = case music_type
  #   when "artist"
  #     RSpotify::Artist.find(id)
  #   when "album"
  #     RSpotify::Album.find(id)
  #   when "track"
  #     RSpotify::Track.find(id)
  #   else
  #     nil
  #   end
    music = "fake"
    self.new(music)
  end
end
