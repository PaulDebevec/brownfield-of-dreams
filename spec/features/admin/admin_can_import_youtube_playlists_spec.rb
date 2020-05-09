require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  scenario "I can import new tutorial with a playlist id" do
    admin = create(:admin)
    # create_list(:tutorial, 2)
    playlist_id = "PLInFNcvpLQv7-_CzTVHjsyIBsMQmerdCG"


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    expect(page).to have_link("Import YouTube Playlist")
    click_link ("Import YouTube Playlist")

    fill_in "Playlist ID", with: playlist_id
    click_button "Import Playlist"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Successfully created tutorial View it here")
    expect(page).to have_link("View it here")
  end

  scenario "I cant import with a bad playlist ID" do
    admin = create(:admin)
    # create_list(:tutorial, 2)
    playlist_id = "invalid ID"


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    expect(page).to have_link("Import YouTube Playlist")
    click_link ("Import YouTube Playlist")

    fill_in "Playlist ID", with: playlist_id
    click_button "Import Playlist"

    expect(current_path).to eq("/admin/tutorials/import")
    expect(page).to have_content("Invalid Playlist ID, Try Again")
  end
end
