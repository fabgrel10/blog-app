require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :all do
    User.destroy_all
    Post.destroy_all
  end

  describe 'with the correct params' do
    before :each do
      User.create(id: 3, name: 'Dummy User 3', email: 'dummy3@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                  password: '123456', posts_counter: 0, confirmed_at: Time.now)
      Post.create(id: 100, title: 'Dummy Post 1', text: 'Dummy Content 1', author_id: 3)
      Post.create(id: 101, title: 'Dummy Post 2', text: 'Dummy Content 2', author_id: 3)
      Post.create(id: 102, title: 'Dummy Post 3', text: 'Dummy Content 3', author_id: 3)
      Post.create(id: 103, title: 'Dummy Post 4', text: 'Dummy Content 4', author_id: 3)

      visit new_user_session_path
      fill_in 'Email', with: 'dummy3@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Dummy User 3'
    end

    it 'can see the user picture' do
      expect(page).to have_selector('img')
    end

    it 'can see the user name' do
      expect(page).to have_content('Dummy User 3')
    end

    it 'show the number of posts' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'can see the user bio' do
      expect(page).to have_content('Bio')
    end

    it 'show the last 3 posts' do
      expect(page).to have_content('Dummy Post 4')
      expect(page).to have_content('Dummy Post 3')
      expect(page).to have_content('Dummy Post 2')
    end

    it 'show the button to see all posts' do
      expect(page).to have_content('See all posts')
    end

    it 'redirects to specific post when clicked' do
      click_link 'Dummy Post 4'
      expect(page.current_path).to eq('/users/3/posts/103')
    end

    it 'redirects to all posts when button is clicked' do
      click_link 'See all posts'
      expect(page.current_path).to eq('/users/3/posts')
    end
  end
end
