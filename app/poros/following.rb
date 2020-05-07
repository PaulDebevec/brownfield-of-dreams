class Following
  attr_reader :name, :html_url
  def initialize(following_info)
    @name = following_info[:name]
    @html_url = following_info[:html_url]
  end
end
