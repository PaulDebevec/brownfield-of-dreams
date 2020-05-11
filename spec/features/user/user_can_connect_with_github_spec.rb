# require 'rails_helper'
#
# RSpec.describe "As a logged in user " , type: :feature do
#   describe "When I connect through github " do
#     before(:each) do
#       OmniAuth.config.test_mode = true
#       OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
#         { "provider" => "github",
#           "info"=> {"name"=> "Alexis Dumortier"},
#           "credentials" =>
#             { "token"=> ENV["GITHUB_USER1_TOKEN"],
#               "expires" => false},
#           "extra" =>
#               {"raw_info" =>
#                 { "login" => "adumortier",
#                   "html_url" => "https://github.com/adumortier",
#                   "name"=> "Alexis Dumortier",
#                 }
#               }
#         }
#       )
#     end
#
#     it "it generates a token for my user" do
#       VCR.use_cassette('/user/user_can_authenticate_through_github') do
#         user1_params = {email: 'dumortier.alexis@gmail.com', first_name: 'Alexis', last_name: 'Dumortier', password: 'temp', role: 0}
#         user1 = User.create!(user1_params)
#         allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
#         visit "/dashboard"
#         click_on "Connect to Github"
#         expect(user1.token).to eq(ENV["GITHUB_USER1_TOKEN"])
#       end
#     end
#   end
# end
#
