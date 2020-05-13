require 'rails_helper'

describe 'as a user when I attempt to visit an admin namespace' do
  it "I see a 404 message page not found message" do
    user = User.create( email: "Pablo@example.com",
                        first_name: "Pablo",
                        last_name: "D",
                        password: "password",
                        token: ENV["GITHUB_TOKEN_1"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
