class Follower
  attr_reader :name, :html_url
  def initialize(follower_info)
    @name = follower_info[:login]
    @html_url = follower_info[:html_url]
  end
end
