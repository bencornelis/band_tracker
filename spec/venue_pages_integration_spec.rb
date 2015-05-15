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
  describe("viewing and editing a venue") do
    it('lets user delete a venue') do
      test_venue = Venue.create(name: "Crystal Ballroom")
      visit("/venues/#{test_venue.id}")
      click_button("Remove venue")
      expect(page).to have_no_content("Crystal Ballroom")
    end

    it("lets user add bands to the list of bands that have played at the venue") do
      test_venue = Venue.create(name: "Crystal Ballroom", location: "Portland")
      band1 = Band.create(name: "Fleet Foxes", origin: "Seattle", year_founded: 2006)
      band2 = Band.create(name: "The Beatles")
      visit("/venues/#{test_venue.id}")
      check(band1.id)
      check(band2.id)
      click_button("Add bands")
      expect(page).to have_content("The Beatles")
    end

    it('lets user change a venue name') do
      test_venue = Venue.create(name: "Crystal Ballroom")
      visit("/venues/#{test_venue.id}")
      click_button("New venue name")
      fill_in("new_name", with: "The Dungeon")
      click_button("change_name")
      expect(page).to have_content("The Dungeon")
    end

    it('finds the best venue for a user based on their music tastes') do
      venue1 = Venue.create(name: "Crystal Ballroom")
      venue2 = Venue.create(name: "McMenamins")
      moby = Band.create(name: "Moby")
      fleet_foxes = Band.create(name: "Fleet Foxes")
      the_beatles = Band.create(name: "The Beatles")
      moby.genres.create(name: "electronic")
      moby.genres.create(name: "blues")
      fleet_foxes.genres.create(name: "folk")
      the_beatles.genres.create(name: "folk")
      the_beatles.genres.create(name: "pop")
      venue1.bands << [moby, fleet_foxes]
      venue2.bands << [fleet_foxes, the_beatles]

      visit("/")
      fill_in("search_genre", with: "folk")
      click_button("Find out!")
      expect(page).to have_content("McMenamins")
    end
  end
end
