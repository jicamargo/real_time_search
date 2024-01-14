# spec/controllers/search_controller_spec.rb
require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  # describe 'GET #index' do
  #   it 'renders the index template' do
  #     get :index
  #     expect(response).to render_template(:index)
  #   end
  # end

  describe 'POST #get_queries' do
    it 'responds with JSON' do
      post 'search/get_queries', params: { query: 'What is a good car' }
      expect(response.content_type).to eq('application/json')
    end

    # it 'returns a success status' do
    #   post :get_queries, params: { query: 'What is a good car' }
    #   expect(response).to have_http_status(:success)
    # end
  end
end
