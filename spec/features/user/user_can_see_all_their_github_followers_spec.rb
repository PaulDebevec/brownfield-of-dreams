require 'rails_helper'

feature "user can view all of their github followers" do

  it "user sees the names of all their followers as links" do
    user = User.create( email: "Pablo@example.com",
                        first_name: "Pablo",
                        last_name: "D",
                        password: "password",
                        token: ENV["GITHUB_TOKEN_1"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_content("GitHub")
    within(first(".followers")) do
      expect(page).to have_css(".follower-name")
      expect(page).to have_link("dancaps")
    end
  end
end
