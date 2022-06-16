require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before :all do
    User.destroy_all
    Post.destroy_all
  end

  context 'when in the index page' do
    before :each do
      User.create(name: 'Dummy User 1', email: 'dummy1@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                  password: '123456', posts_counter: 0, confirmed_at: Time.now)
      User.create(name: 'Dummy User 2', email: 'dummy2@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                  password: '123456', posts_counter: 5, confirmed_at: Time.now)

      visit new_user_session_path

      fill_in 'Email', with: 'dummy1@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'can see all the usernames' do
      expect(page).to have_content('Dummy User 1')
      expect(page).to have_content('Dummy User 2')
    end

    it 'can see the profile picture for each user' do
      expect(page).to have_selector('img', count: 2)
    end

    it 'can see the profile picture for each user' do
      expect(page).to have_content('Number of posts: 0')
      expect(page).to have_content('Number of posts:')
    end

    it "when click on a user, it redirects to that user's show pag" do
      click_link 'Dummy User 1'
      expect(page).to have_content('Bio')
    end
  end
end
