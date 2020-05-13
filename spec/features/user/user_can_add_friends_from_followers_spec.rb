require 'rails_helper'

describe 'User' do
  it 'can add friends from their dashboard' do
    VCR.use_cassette('site_friend_cassette') do
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

        within '.followers' do
          expect(page).to have_link("Add as Friend")
          click_link("Add as Friend")
        end

      expect(page).to have_content("Successfully Added Friend!")
      expect(user_1.friends.length).to eq(1)
      expect(current_path).to eq(dashboard_path)
    end
  end

  it "cannot add a friend that you are already friends with" do
    VCR.use_cassette('site_friend_once_cassette') do
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

        within '.following' do
          expect(page).to have_link("Add as Friend")
          click_link("Add as Friend")
        end

      visit(dashboard_path)
      expect(page).to_not have_link("Add as Friend")
    end
  end

  it "added friends appear in a section on the dashboard" do
    VCR.use_cassette('friends_on_dashboard_cassette') do
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

      within '.following' do
        expect(page).to have_link("Add as Friend")
        click_link("Add as Friend")
      end
      expect(current_path).to eq(dashboard_path)

      within '.my_friends' do
        expect(page).to have_content("Fred Rondina")
        expect(page).to have_content("fredrondina96")
      end
    end
  end
end
