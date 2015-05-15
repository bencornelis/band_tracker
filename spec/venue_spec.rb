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
end
