require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    user_2 = User.create(
     email: 'fredrondina96@gmail.com',
     first_name: 'Fred',
     last_name: 'Rondina',
     password: 'password_1',
     login: 'fredrondina96',
     token: ENV["GITHUB_TOKEN_2"],
     role: :default,
   )
   user_1 = User.create(
     email: 'paulmdebevec@gmail.com',
     first_name: 'Paul',
     last_name: 'Debevec',
     password: 'password_2',
     login: 'PaulDebevec',
     token: ENV["GITHUB_TOKEN_1"],
     role: :default,
   )

    user3 = create(:user)
    user3.token = "No Key"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit(dashboard_path)
    expect(page).to have_link("Add as Friend")
    click_link("Add as Friend")
  end
end
