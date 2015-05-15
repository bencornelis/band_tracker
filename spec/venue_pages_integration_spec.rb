require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("the venue path", type: :feature) do
  describe("adding and displaying a venue") do
    it('processes user entry to add and display a venue on the home page') do
      visit('/')
      fill_in('venue_name', with: "Crystal Ballroom")
      fill_in('location', with: "Portland")
      click_button('add_venue')
      expect(page).to have_content("Crystal Ballroom")
    end
  end
end
