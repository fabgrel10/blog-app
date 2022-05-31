require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'GET /index' do
    before(:example) { get '/users/:user_id/posts' }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the posts#index template' do
      expect(response).to render_template(:index)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('/show')
    end

    it 'renders the correct p element inner text' do
      expect(response.body).to include('Posts#index')
    end
  end

  context 'GET /show' do
    before(:example) { get '/users/:user_id/posts/:id' }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it 'renders the Posts#show template' do
      expect(response).to render_template(:show)
    end

    it 'renders the correct p element inner text' do
      expect(response.body).to include('Posts#show')
    end
  end
end
