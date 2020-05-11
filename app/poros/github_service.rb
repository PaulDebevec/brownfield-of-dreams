class GithubService
  def initialize(token)
    @token = token
  end

  def repository_data
    @repository_data ||= get_json("/user/repos?access_token=#{@token}")
  end

  def follower_data
    @follower_data ||= get_json("/user/followers?access_token=#{@token}")
  end

  def following_data
    @following_data ||= get_json("/user/following?access_token=#{@token}")
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
