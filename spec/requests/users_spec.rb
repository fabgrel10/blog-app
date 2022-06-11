require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before :all do
    @user = User.create(name: 'Test User', photo: 'https://example.com/test.jpg', bio: 'I am a test user ',
                        posts_counter: 0)
  end

  describe '.index' do
    before { get users_path }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('/show')
    end

    it 'includes a placeholder' do
      expect(response.body).to include('Test User')
    end
  end

  describe '.show' do
    before { get "/users/#{@user.id}" }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('/index')
    end

    it 'has a user name' do
      expect(response.body).to include('Test User')
    end

    it 'has no posts' do
      expect(response.body).to include('Number of posts: 0')
    end

    it 'has a user bio' do
      expect(response.body).to include('I am a test user')
    end
  end
end
