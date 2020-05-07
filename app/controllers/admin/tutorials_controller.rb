class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    #This is where I will put all of my goodies for now
  end

  def import
    # service = Faraday.get(url: "https://www.googleapis.com/youtube/v3/") do |faraday|
    #   faraday.params["part"] = "contentDetails"
    #   faraday.params["playlistId"] = params[:playlist_id]
    #   faraday.params["key"] = ENV["YOUTUBE_API_KEY"]

      service = Faraday.new(url: "https://www.googleapis.com")
      videos = service.get("/youtube/v3/playlistItems?part=contentDetails&playlistId=#{params[:playlist_id]}&key=#{ENV["YOUTUBE_API_KEY"]}&maxResults=20")
      @videos = JSON.parse(videos.body, symbolize_names: true)
      binding.pry
      @videos = @videos[:items].map {|video| video[:contentDetails][:videoId]}
        binding.pry

    # repositories = service.get("/user/repos?access_token=#{ENV['GITHUB_TOKEN_1']}")
    # @top_5_repos = JSON.parse(repositories.body, symbolize_names: true)[0..4]
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
    params.require(:tutorial).permit(:tag_list)
  end
end
