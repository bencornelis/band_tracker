require "spec_helper"

describe(Genre) do
  it { should belong_to(:band) }
end
