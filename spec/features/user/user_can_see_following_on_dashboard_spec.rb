require 'rails_helper'

feature "user can see their following" do

  it "user sees the names of all the people following them as links" do
    VCR.use_cassette('github_following_cassette') do
      user = User.create( email: "Pablo@example.com",
                          first_name: "Pablo",
                          last_name: "D",
                          password: "password",
                          token: ENV["GITHUB_TOKEN_1"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/dashboard'

      within(first(".following")) do
        expect(page).to have_css(".following-name")
        expect(page).to have_link("amites")
      end
    end
  end
end
