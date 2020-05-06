class UsersController < ApplicationController
  def show
    repositories = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["GITHUB_TOKEN_1"]
    end

    response = repositories.get("/user/repos?access_token=#{ENV['GITHUB_TOKEN_1']}")
    @top_5_repos = JSON.parse(response.body, symbolize_names: true)[0..4]
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end




  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
