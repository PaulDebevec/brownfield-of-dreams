class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial,
  :dependent => :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail, presence: true

  def valid_thumbnail?
    valid_file_types = [".PNG", ".GIF", ".BMP", ".JPG"]
    valid_file_types.include?(self.thumbnail.last(4).upcase)
  end
end
