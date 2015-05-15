require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("the band path", type: :feature) do
  describe("adding and displaying a band") do
    it('processes user entry to add and display a band on the home page') do
      visit('/')
      fill_in('band_name', with: "Fleet Foxes")
      fill_in('origin', with: "Seattle, Washington")
      fill_in('year_founded', with: 2006)
      click_button('add_band')
      expect(page).to have_content("Fleet Foxes")
    end
  end
end
