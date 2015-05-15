class Band < ActiveRecord::Base
  has_and_belongs_to_many :venues
  has_many :genres
  validates :name, presence: true
  before_save :capitalize


  def unplayed_venues
    unplayed_venues = Venue.all.select { |venue| !venues.include?(venue)}
  end

private
  def capitalize
    split_name_capitalized = name.split.map { |word| word.capitalize }
    self.name = split_name_capitalized.join(' ')
  end
end
