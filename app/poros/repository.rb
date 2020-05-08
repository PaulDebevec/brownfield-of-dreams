class Repository
  attr_reader :name, :repo_url
  def initialize(repo_info)
    @name = repo_info[:name]
    @repo_url = repo_info[:repo_url]
  end
end
