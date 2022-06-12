require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:all) do
    @author = User.create(name: 'Test User', photo: 'https://example.com/test.jpg', bio: 'I am a test user ',
                          posts_counter: 0)

    @post = Post.create(
      author: @author,
      title: 'Test Post',
      text: 'I am a test post',
      comments_counter: 5,
      likes_counter: 10
    )
  end

  context '.index' do
    before { get user_posts_path(@author.id) }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('/show')
    end

    it 'renders the correct author name' do
      expect(response.body).to include('Test User')
    end
  end

  context '.show' do
    before { get user_post_path(@author.id, @post.id) }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'renders the correct p element inner text' do
      expect(response.body).to include('I am a test post')
    end
  end
end
