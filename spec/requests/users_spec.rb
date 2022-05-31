require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:each) { get users_path }

    it 'returns a 200 status code or ok response' do
      expect(response).to have_http_status(200)
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('/show')
    end

    it 'includes a placeholder' do
      expect(response.body).to include('Users#index')
    end
  end

  describe 'GET #show' do
    before(:each) { get '/users/:id' }

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

    it 'includes a placeholder' do
      expect(response.body).to include('Users#show')
    end
  end
end
