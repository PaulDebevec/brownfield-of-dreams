class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save && @tutorial.valid_thumbnail?
      flash[:success] = "Successfully created tutorial."
      redirect_to "/tutorials/#{@tutorial.id}"
    else
      flash.now[:error] = @tutorial.errors.full_messages.to_sentence
      flash.now[:error] = "Thumbail must be a .JPG, .GIF, .BMP, or .PNG" if !@tutorial.valid_thumbnail?
      render :new
    end
  end

  def new_import
  end

  def import
      service = Faraday.new(url: "https://www.googleapis.com")
      videos = service.get("/youtube/v3/playlistItems?part=snippet&playlistId=#{params[:playlist_id]}&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=50")
      playlist_info = service.get("/youtube/v3/playlists?part=snippet&id=#{params[:playlist_id]}&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=50")
      @videos_raw = JSON.parse(videos.body, symbolize_names: true)
      @playlist = JSON.parse(playlist_info.body, symbolize_names: true)

      playlist_data = Hash.new

      if @playlist[:items].first == nil
        flash[:error] = "Invalid Playlist ID, Try Again"
        redirect_to "/admin/tutorials/import"
      else
        playlist_data["title"] = @playlist[:items].first[:snippet][:title]
        playlist_data["description"] = @playlist[:items].first[:snippet][:description]
        playlist_data["thumbnail"] =  @playlist[:items].first[:snippet][:thumbnails][:standard][:url]
        playlist_data["playlist_id"] = @playlist[:items].first[:id]
        playlist_data["classroom"] = false
        playlist_data["description"] = "No Description Available" if playlist_data["description"] = ""

        @new_playlist = Tutorial.create!(playlist_data)

          @videos_raw[:items].each_with_index do |video, index|
            video_data = Hash.new
            video_data["title"] = video[:snippet][:title]
            video_data["description"] = video[:snippet][:description]
            video_data["video_id"] =  video[:snippet][:resourceId][:videoId]
            video_data["thumbnail"] = video[:snippet][:thumbnails][:medium][:url]
            video_data["position"] = (index+1)
            @new_playlist.videos.create!(video_data)
          end
        flash[:success] = "Successfully created tutorial #{view_context.link_to 'View it here', "/tutorials/#{@new_playlist.id}"}"
        redirect_to admin_dashboard_path
      end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :tag_list)
  end
end
