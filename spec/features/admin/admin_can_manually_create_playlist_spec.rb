require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  scenario "can manually create a playlist" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in "Title", with: "My Test Tutorial"
    fill_in "Description", with: "Test Description"
    fill_in "Thumbnail", with: "https://www.insuranceexamguides.com/wp-content/uploads/2018/08/check-mark-2-xxl.png"

    click_button "Save"

    expect(current_path).to_not eq("/admin/tutorials/new")
    expect(page).to have_content("Successfully created tutorial.")
  end

  scenario "Playlist will not create if sections are left blank" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in "Title", with: "My Test Tutorial"
    fill_in "Thumbnail", with: "https://www.insuranceexamguides.com/wp-content/uploads/2018/08/check-mark-2-xxl.png"

    click_button "Save"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "Playlist will not create if thumbnail is not an accepted file type" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in "Title", with: "My Test Tutorial"
    fill_in "Description", with: "Test Description"
    fill_in "Thumbnail", with: "https://www.insuranceexamguides.com/wp-content/upl"
    click_button "Save"

    expect(page).to have_content("Thumbail must be a .JPG, .GIF, .BMP, or .PNG")
  end
end
