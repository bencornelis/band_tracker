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

  describe("viewing and editing a band") do
    it('lets user delete a band') do
      test_band = Band.create(name: "Fleet Foxes", origin: "Seattle", year_founded: 2006)
      visit("/bands/#{test_band.id}")
      click_button("Remove band")
      expect(page).to have_no_content("Fleet Foxes")
    end
  end
end
