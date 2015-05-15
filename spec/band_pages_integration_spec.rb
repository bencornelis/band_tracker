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

    it("lets user add venues to the list of venues a band has played at") do
      test_band = Band.create(name: "Fleet Foxes", origin: "Seattle", year_founded: 2006)
      venue1 = Venue.create(name: "Crystal Ballroom", location: "Portland")
      venue2 = Venue.create(name: "second venue", location: "San Francisco")
      venue3 = Venue.create(name: "third venue", location: "San Diego")
      visit("/bands/#{test_band.id}")
      check(venue1.id)
      check(venue3.id)
      click_button("Add venues")
      expect(page).to have_content("Crystal Ballroom Third Venue")
    end

    it('lets user change a band name') do
      test_band = Band.create(name: "Fleet Foxes", origin: "Seattle", year_founded: 2006)
      visit("/bands/#{test_band.id}")
      click_button("New band name")
      fill_in("new_name", with: "The Fleet Foxes")
      click_button("change_name")
      expect(page).to have_content("The Fleet Foxes")
    end
  end
end
