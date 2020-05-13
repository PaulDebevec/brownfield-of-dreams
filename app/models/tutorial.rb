class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial,
  :dependent => :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def valid_thumbnail?
    valid_file_types = [".PNG", ".GIF", ".BMP", ".JPG"]
    valid_file_types.include?(self.thumbnail.last(4).upcase)
  end

  def self.load_playlist_data(playlist_id)
    service = Faraday.new(url: "https://www.googleapis.com")
    playlist_info = service.get("/youtube/v3/playlists?part=snippet&id=#{playlist_id}&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=50")
    @playlist = JSON.parse(playlist_info.body, symbolize_names: true)

    playlist_data = Hash.new

    if @playlist[:items].first == nil
      return false
    else
      playlist_data["title"] = @playlist[:items].first[:snippet][:title]
      playlist_data["description"] = @playlist[:items].first[:snippet][:description]
      playlist_data["thumbnail"] =  @playlist[:items].first[:snippet][:thumbnails][:standard][:url]
      playlist_data["playlist_id"] = @playlist[:items].first[:id]
      playlist_data["classroom"] = false
      playlist_data["description"] = "No Description Available" if playlist_data["description"] = ""
    end
    return playlist_data
  end
end
