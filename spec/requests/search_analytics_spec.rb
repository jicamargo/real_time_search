require 'rails_helper'

RSpec.describe "Search Integration Test", type: :system do
  it "searches for 'what is a good car'" do
    visit root_path

    # Enter 'what' in the search input
    fill_in "input", with: "what"
    click_button "Search"
    expect(page).to have_content("what")

    # Enter 'what is' in the search input
    fill_in "input", with: "what is"
    click_button "Search"
    expect(page).to have_content("what is")

    # Enter 'what is a good' in the search input
    fill_in "input", with: "what is a good"
    click_button "Search"
    expect(page).to have_content("what is a good")

    # Enter 'what is a good car' in the search input
    fill_in "input", with: "what is a good car"
    click_button "Search"
    expect(page).to have_content("what is a good car")

    # Verify that only the exact phrase is present in the result list
    within "#result-list" do
      expect(page).to have_selector("li", count: 1)
      expect(page).to have_content("what is a good car")
    end

    # Navigate to the Analytics page
    click_link 'Analytics'

    # Wait for the Analytics page to load using have_selector
    expect(page).to have_selector('#table_analytics_1 td', text: 'Guest', wait: 10)

    # Verify the content on the Analytics page
    expect(page).to have_content('Search Analytics')
    expect(page).to have_selector('table', count: 4) # Verify all 4 tables are present

    # Verify results in the first table (Queries by User)
    expect(page).to have_css('#table_analytics_1 td', text: 'Guest')
    expect(page).to have_css('#table_analytics_1 td', text: 'what is a good car')
    expect(page).to have_css('#table_analytics_1 td', text: '1')

    # Verify results in the second table (Users with Most Queries)
    expect(page).to have_css('#table_analytics_2 td', text: 'Guest')
    expect(page).to have_css('#table_analytics_2 td', text: '1')

    # Verify results in the third table (Day of the Week with Most Queries)
    expect(page).to have_css('#table_analytics_3 td', text: /\w+/)
    expect(page).to have_css('#table_analytics_3 td', text: '1')

    # Verify results in the fourth table (Popular Words)
    expect(page).to have_css('#table_analytics_4 td', text: 'car')
    expect(page).to have_css('#table_analytics_4 td', text: 'good')
    
  end
end
