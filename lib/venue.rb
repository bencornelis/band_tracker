class Venue < ActiveRecord::Base
  has_and_belongs_to_many :bands
  validates :name, presence: true
  before_save :capitalize

  def unhosted_bands
    unhosted_bands = Band.all.select { |band| !bands.include?(band)}
  end

  def self.best_for_genre(genre_name)
    highest_genre_count, best_venue = 0, nil
    all.each do |venue|
      genre_count = 0
      venue.bands.each do |band|
        genre_names = band.genres.map { |genre| genre.name }
        genre_count += 1 if genre_names.include?(genre_name)
      end
      if genre_count > highest_genre_count
        highest_genre_count, best_venue = genre_count, venue
      end
    end
    best_venue
  end

private
  def capitalize
    split_name = name.split
    split_name.each { |word| word[0] = word[0].capitalize }
    self.name = split_name.join(' ')
  end
end
