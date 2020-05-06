require 'rails_helper'

feature "user can view 5 github repos on their dashboard" do

  it "user visits dashboard" do
    user = User.create( email: "Pablo@example.com",
                        first_name: "Pablo",
                        last_name: "D",
                        password: "password",
                        token: ENV["GITHUB_TOKEN_1"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_content("GitHub")
    within(first(".repos")) do
      expect(page).to have_css(".name")
      expect(page).to have_link("brownfield-of-dreams")
    end
  end
end
