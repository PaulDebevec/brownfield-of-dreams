require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'cannot see tutorials that are classroom content' do

      prework_tutorial_data = {
        "title"=>"CLASSIFED, NOT FOR VISITORS",
        "description"=>"Videos for prework.",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
        "classroom"=>true,
      }

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = Tutorial.create!(prework_tutorial_data)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)
      video5 = create(:video, tutorial_id: tutorial3.id)

      visit root_path

      expect(page).to_not have_content(tutorial3.title)
      expect(page).to_not have_content(tutorial3.description)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
        expect(page).to have_content(tutorial2.title)
        expect(page).to have_content(tutorial2.description)
      end
    end
  end
end
