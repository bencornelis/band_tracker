require "spec_helper"

describe(Venue) do
  it { should have_and_belong_to_many(:bands) }

  it("has a name") do
    venue = Venue.new(name: "")
    expect(venue.save).to eq(false)
  end

  it("always has a capitalized name") do
    venue = Venue.create(name: "crystal ballroom")
    expect(venue.name).to eq("Crystal Ballroom")
  end

  describe("#unhosted_bands") do
    it("returns a list of bands the venue has not hosted") do
      venue = Venue.create(name: "Crystal Ballroom")
      band1 = Band.create(name: "fleet foxes")
      band2 = Band.create(name: "the tallest man on earth")
      venue.bands << band2
      expect(venue.unhosted_bands).to eq([band1])
    end
  end

  describe(".best_for_genre") do
    it("returns the venue with the most hosted bands that play a given genre of music") do
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

      expect(Venue.best_for_genre("folk")).to eq(venue2)
    end
  end
end
