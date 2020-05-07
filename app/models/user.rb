class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates_presence_of :token
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def top_5_repos
    search ||= GithubSearch.new(ENV['GITHUB_TOKEN_1'])
    @top_5_repos = search.repositories
    @top_5_repos
  end
end
