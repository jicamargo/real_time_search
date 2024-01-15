require 'rails_helper'

RSpec.describe SearchStory, type: :model do

  it 'is valid with valid attributes' do
    search_story = SearchStory.new(query: 'What is a good car', ip_address: '127.0.0.2', user_name: 'Guest')
    expect(search_story).to be_valid
  end

  it 'is not valid without a query' do
    search_story = SearchStory.new(ip_address: '127.0.0.1', user_name: 'Guest')
    expect(search_story).to_not be_valid
  end
end
