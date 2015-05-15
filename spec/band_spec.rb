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

end
