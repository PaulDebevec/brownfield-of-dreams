require 'rails_helper'

RSpec.describe "As a logged in user" , type: :feature do
  describe "when I click connect with github" do
    before(:each) do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        { "provider" => "github",
          "info"=> {"name"=> "Paul Debevec"},
          "credentials" =>
            { "token"=> ENV["GITHUB_TOKEN_1"],
              "expires" => false},
          "extra" =>
              {"raw_info" =>
                { "login" => "pauldebevec",
                  "html_url" => "https://github.com/pauldebevec",
                  "name"=> "Paul Debevec",
                }
              }
        }
      )
    end

    it "My github key is saved to my user" do
      VCR.use_cassette('github_authentication') do
        user_params = {email: 'paulmdebevec@gmail.com', first_name: 'Paul', last_name: 'Debevec', password: 'password', role: 0}
        user = User.create!(user_params)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit "/dashboard"
        click_on "Connect to Github"
        expect(user.token).to eq(ENV["GITHUB_TOKEN_1"])
      end
    end
  end
end
