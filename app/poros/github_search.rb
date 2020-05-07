class GithubSearch
  def initialize(token)
    @token = token
    @github_service = GithubService.new
  end

  def repositories
    @repositories ||= @github_service.repository_data.map do |repo_params|
      Repository.new({name: repo_params['name'], repo_url: repo_params['html_url']})
    end
    @repositories[0..4]
  end
end
