require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
  end

  describe "instance methods" do
    it "valid_thumbnail?" do
      tutorial = create(:tutorial)
      expect(tutorial.valid_thumbnail?).to eq(true)
      tutorial.thumbnail = "invalid thumbnail"
      expect(tutorial.valid_thumbnail?).to eq(false)
    end
  end

end
