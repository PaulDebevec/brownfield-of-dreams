class GithubSearch
  def initialize(token)
    @token = token
    @github_service = GithubService.new(token)
  end

  def repositories
    @repositories ||= @github_service.repository_data.map do |repo_par|
      Repository.new({ name: repo_par['name'], repo_url: repo_par['html_url'] })
    end
    @repositories[0..4]
  end

  def followers
    @followers ||= @github_service.follower_data.map do |fr_par|
      Follower.new({ login: fr_par['login'], html_url: fr_par['html_url'] })
    end
  end

  def following
    @following ||= @github_service.following_data.map do |fg_par|
      Following.new({ name: fg_par['login'], html_url: fg_par['html_url'] })
    end
  end
end
