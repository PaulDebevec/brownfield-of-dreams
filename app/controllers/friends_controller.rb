class FriendsController < ApplicationController
  def create
    current_user.add_friend(params["login"])
  end
end
