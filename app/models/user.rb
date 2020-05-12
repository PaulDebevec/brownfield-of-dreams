class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :friends, dependent: :destroy
  has_many :user_friends, through: :friends
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

  def add_friend(friends_username)
    friend = User.find_by(login: friends_username)
    Friend.create(user_id: id, user_friend_id: friend.id)
    Friend.create(user_id: friend.id, user_friend_id: id)
  end

  def valid_friend?(potential_friend)
    new_friend = User.find_by(login: potential_friend.name)
      if self.friends.length == 0
        true
      else
        self.friends.each do |current_friend|
          return false if current_friend.user_friend_id == new_friend.id
        end
      end
    true
  end

  def load_friends
    unless self.friends.length == 0
      all_friends = self.friends.map do |friend|
        User.find(friend.user_friend_id)
      end
    return all_friends
    end
  end
end
