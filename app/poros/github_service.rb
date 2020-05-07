class GithubService
  def repository_data
    @repository_data ||= get_json("/user/repos?access_token=#{ENV['GITHUB_TOKEN_1']}")
  end
  private
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body)
  end

  def conn
    Faraday.new(url: 'https://api.github.com')
  end
end
