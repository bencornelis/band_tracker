require "spec_helper"

describe(Band) do
  it { should have_and_belong_to_many(:venues) }
  it { should have_many(:genres) }
end
