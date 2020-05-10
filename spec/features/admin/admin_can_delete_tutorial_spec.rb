require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user)
    .and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end


  scenario 'and it deletes the videos belonging to that turorial' do
    admin = create(:admin)
    create_list(:tutorial, 2)
    tutorial_1 = Tutorial.first
    tutorial_2 = Tutorial.last

    tutorial_1.videos << create_list(:video, 2)
    tutorial_1_video_1_id = tutorial_1.videos.first.id.to_i
    tutorial_1_video_2_id = tutorial_1.videos.last.id.to_i

    tutorial_2.videos << create(:video)

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(admin)

    visit '/admin/dashboard'

    expect(Video.count).to eq(3)

    within("#tutorial-#{tutorial_1.id}") do
      click_link 'Delete'
    end

    expect(Video.count).to eq(1)
    expect(Video.first.title).to eq(tutorial_2.videos.first.title)
    expect(Video.where(id: tutorial_1_video_1_id)).to eq([])
    expect(Video.where(id: tutorial_1_video_2_id)).to eq([])
  end
end
