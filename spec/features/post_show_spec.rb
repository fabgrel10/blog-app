require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  describe 'show' do
    before :all do
      Post.destroy_all
      User.destroy_all
    end

    before(:each) do
      User.create(id: 4, name: 'Dummy User 4', email: 'dummy4@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                  password: '123456', posts_counter: 0, confirmed_at: Time.now)
      Post.create(id: 101, title: 'Dummy Post 2', text: 'Dummy Content 2', author_id: 4)

      Comment.create(id: 100, text: 'Dummy Comment 1', author_id: 4, post_id: 101)
      Comment.create(id: 102, text: 'Dummy Comment 2', author_id: 4, post_id: 101)
      Comment.create(id: 103, text: 'Dummy Comment 3', author_id: 4, post_id: 101)

      Like.create(id: 100, author_id: 4, post_id: 101)
      Like.create(id: 101, author_id: 4, post_id: 101)

      visit new_user_session_path
      fill_in 'Email', with: 'dummy4@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Dummy User 4'
      click_link 'Dummy Post 2'
    end

    it 'show the title' do
      expect(page).to have_content('Dummy Post 2')
    end

    it 'show the author name' do
      expect(page).to have_content('Dummy User 4')
    end

    it 'show comment counter' do
      expect(page).to have_content('Comments: 3')
    end

    it 'show likes counter' do
      expect(page).to have_content('Likes: 2')
    end

    it 'show the post\'s content' do
      expect(page).to have_content('Dummy Content 2')
    end

    it 'show user name of each commentor' do
      expect(page).to have_content('Dummy User 4:')
    end

    it 'show the comment\'s content' do
      expect(page).to have_content('Dummy Comment 1')
      expect(page).to have_content('Dummy Comment 2')
      expect(page).to have_content('Dummy Comment 3')
    end
  end
end
