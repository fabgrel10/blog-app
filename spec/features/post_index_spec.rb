require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  describe 'index' do
    before :all do
      Post.destroy_all
      User.destroy_all
    end

    before(:each) do
      User.create(id: 3, name: 'Dummy User 3', email: 'dummy3@example.com', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                  password: '123456', posts_counter: 0, confirmed_at: Time.now)
      Post.create(id: 100, title: 'Dummy Post 1', text: 'Dummy Content 1', author_id: 3)
      Post.create(id: 101, title: 'Dummy Post 2', text: 'Dummy Content 2', author_id: 3)
      Post.create(id: 102, title: 'Dummy Post 3', text: 'Dummy Content 3', author_id: 3)
      Post.create(id: 103, title: 'Dummy Post 4', text: 'Dummy Content 4', author_id: 3)

      Comment.create(id: 100, text: 'Dummy Comment 1', author_id: 3, post_id: 103)
      Comment.create(id: 102, text: 'Dummy Comment 2', author_id: 3, post_id: 103)
      Comment.create(id: 103, text: 'Dummy Comment 3', author_id: 3, post_id: 103)

      Like.create(id: 100, author_id: 3, post_id: 103)
      Like.create(id: 101, author_id: 3, post_id: 103)

      visit new_user_session_path
      fill_in 'Email', with: 'dummy3@example.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Dummy User 3'
      click_link 'See all posts'
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

    it 'show the post\'s title' do
      expect(page).to have_content('Dummy Post 1')
    end

    it 'show some of the post\'s content' do
      expect(page).to have_content('Dummy Content 1')
    end

    it 'show the last comment' do
      expect(page).to have_content('Dummy Comment 3')
    end

    it 'show the number of comments' do
      expect(page).to have_content('Comments: 3')
    end

    it 'show the number of likes' do
      expect(page).to have_content('Likes: 2')
    end

    it 'when clicked, redirects to specific post' do
      click_link 'Dummy Post 1'
      expect(page.current_path).to eq('/users/3/posts/100')
    end
  end
end
