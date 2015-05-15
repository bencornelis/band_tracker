class Venue < ActiveRecord::Base
  has_and_belongs_to_many :bands
  validates :name, presence: true
  before_save :capitalize

  def unhosted_bands
    unhosted_bands = Band.all.select { |band| !bands.include?(band)}
  end

private
  def capitalize
    split_name_capitalized = name.split.map { |word| word.capitalize }
    self.name = split_name_capitalized.join(' ')
  end
end
