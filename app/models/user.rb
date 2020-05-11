class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates_presence_of :token
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def bookmarks_list
    Video.select('videos.*, tutorials.id as tutorial_id, user_videos.user_id')
      .joins(:tutorial)
      .joins(:user_videos)
      .where(user_videos: {user_id: self.id})
      .order(:tutorial_id)
      .order(:position)
  end

  def top_5_repos(token)
    search ||= GithubSearch.new(token)
    @top_5_repos = search.repositories
    @top_5_repos
  end

  def all_followers(token)
    search ||= GithubSearch.new(token)
    @all_followers = search.followers
    @all_followers
  end

  def all_following(token)
    search ||= GithubSearch.new(token)
    @all_following = search.following
    @all_following
  end

  def self.has_account?(followers_name)
    User.find_by(login: followers_name)
  end
end
