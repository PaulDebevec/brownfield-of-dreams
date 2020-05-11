class GithubSearch
  def initialize(token)
    @token = token
    @github_service = GithubService.new(token)
  end

  def repositories
    @repositories ||= @github_service.repository_data.map do |repo_params|
      Repository.new({name: repo_params['name'], repo_url: repo_params['html_url']})
    end
    @repositories[0..4]
  end

  def followers
    @followers ||= @github_service.follower_data.map do |follower_params|
      Follower.new({login: follower_params['login'], html_url: follower_params['html_url']})
    end
  end

  def following
    @following ||= @github_service.following_data.map do |following_params|
      Following.new({name: following_params['login'], html_url: following_params['html_url']})
    end
  end
end
