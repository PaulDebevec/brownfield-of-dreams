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
    tutorial_attributes = Tutorial.load_playlist_data(params[:playlist_id])
      if tutorial_attributes == false
        flash[:error] = "Invalid Playlist ID, Try Again"
        redirect_to "/admin/tutorials/import"
      else
        @new_playlist = Tutorial.create!(tutorial_attributes)
        @new_playlist.import_videos(params[:playlist_id])
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
