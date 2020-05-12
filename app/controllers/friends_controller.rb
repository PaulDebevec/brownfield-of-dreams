class FriendsController < ApplicationController
  def create
    current_user.add_friend(params["login"])
    flash[:success] = "Successfully Added Friend!"
    current_user.reload

    redirect_to dashboard_path
  end
end
