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
end
