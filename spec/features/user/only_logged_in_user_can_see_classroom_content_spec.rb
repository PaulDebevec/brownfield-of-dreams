require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'welcome page' do
    it "classroom content is only visible if I'm logged in" do
      prework_tutorial_data = {
        'title' => 'Back End Engineering - Prework',
        'description' => 'Videos for prework.',
        'thumbnail' => 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg',
        'playlist_id' => 'PL1Y69f0xPbdN6C-LPuTF5yzlBol2joCa5',
        'classroom' => false
      }

      prework_tutorial = Tutorial.create!(prework_tutorial_data)

      mod1_tutorial_data = {
        'title' => 'Back End Engineering - Module 1',
        'description' => 'Videos related to Mod 1.',
        'thumbnail' => 'https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg',
        'playlist_id' => 'PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb',
        'classroom' => true
      }

      m1_tutorial = Tutorial.create!(mod1_tutorial_data)

      mod3_tutorial_data = {
        'title' => 'Back End Engineering - Module 3',
        'description' => 'Video content for Mod 3.',
        'thumbnail' => 'https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg',
        'playlist_id' => 'PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ',
        'classroom' => true,
        'tag_list' => ['Internet', 'BDD', 'Ruby']
      }

      m3_tutorial = Tutorial.create!(mod3_tutorial_data)

      visit '/'

      within "#tutorial-#{prework_tutorial.id}" do
        expect(page).to have_link(prework_tutorial.title)
      end

      within "#tutorial-#{m1_tutorial.id}" do
        expect(page).to have_content('Classroom Content')
      end

      within "#tutorial-#{m3_tutorial.id}" do
        expect(page).to have_content('Classroom Content')
      end

      user1_params = { email: 'test@example.com', first_name: 'Bobbie', last_name: 'Draper', password: 'martian', role: 0, token: ENV['GITHUB_TOKEN_1'] }
      @user1 = User.create(user1_params)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/'

      within "#tutorial-#{prework_tutorial.id}" do
        expect(page).to have_link(prework_tutorial.title)
      end

      within "#tutorial-#{m1_tutorial.id}" do
        expect(page).to have_link(m1_tutorial.title)
      end

      within "#tutorial-#{m3_tutorial.id}" do
        expect(page).to have_link(m3_tutorial.title)
      end
    end
  end
end
