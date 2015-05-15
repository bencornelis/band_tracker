require "spec_helper"

describe(Band) do
  it { should have_and_belong_to_many(:venues) }

  it { should have_many(:genres) }

  it("has a name") do
    band = Band.new(name: "")
    expect(band.save).to eq(false)
  end

  it("always has a capitalized name") do
    band = Band.create(name: "fleet foxes")
    expect(band.name).to eq("Fleet Foxes")
  end

  describe("#unplayed_venues") do
    it("returns a list of venues the band hasn't played at") do
      band = Band.create(name: "fleet foxes")
      venue1 = Venue.create(name: "Crystal Ballroom")
      venue2 = Venue.create(name: "McMenamins")
      band.venues << venue2
      expect(band.unplayed_venues).to eq([venue1])
    end
  end

end
