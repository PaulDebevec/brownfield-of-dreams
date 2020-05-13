class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial,
                                                  dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def valid_thumbnail?
    valid_file_types = ['.PNG', '.GIF', '.BMP', '.JPG']
    valid_file_types.include?(thumbnail.last(4).upcase)
  end

  def self.load_playlist_data(playlist_id)
    service = Faraday.new(url: "https://www.googleapis.com")
    part = "?part=snippet&id=#{playlist_id}"
    key = "&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=50"
    playlist_info = service.get("/youtube/v3/playlists#{part}#{key}")
    @playlist = JSON.parse(playlist_info.body, symbolize_names: true)

    playlist_data = Hash.new

    if @playlist[:items].first == nil
      return false
    else
      playlist_data["title"] = @playlist[:items].first[:snippet][:title]
      playlist_data["description"] = @playlist[:items]
                                .first[:snippet][:description]
      playlist_data["thumbnail"] =  @playlist[:items]
                                .first[:snippet][:thumbnails][:standard][:url]
      playlist_data["playlist_id"] = @playlist[:items].first[:id]
      playlist_data["classroom"] = false
      if playlist_data["description"] = ""
        playlist_data["description"] = "No Description Available"
      end
    end
    return playlist_data
  end

  def import_videos(playlist_id)
    service = Faraday.new(url: "https://www.googleapis.com")
    part = "?part=snippet&playlistId=#{playlist_id}"
    key = "&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=50"
    videos = service.get("/youtube/v3/playlistItems#{part}#{key}")
    @videos_raw = JSON.parse(videos.body, symbolize_names: true)
      @videos_raw[:items].each_with_index do |video, index|
        video_data = Hash.new
        next if video[:snippet][:title] == "Private video"
        video_data["title"] = video[:snippet][:title]
        video_data["description"] = video[:snippet][:description]
        video_data["video_id"] =  video[:snippet][:resourceId][:videoId]
        video_data["thumbnail"] = video[:snippet][:thumbnails][:medium][:url]
        video_data["position"] = (index+1)
        self.videos.create!(video_data)
      end
  end
end
