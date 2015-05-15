class Band < ActiveRecord::Base
  has_and_belongs_to_many :venues
  has_many :genres
  validates :name, presence: true
  before_save :capitalize

private
  def capitalize
    split_name_capitalized = name.split.map { |word| word.capitalize }
    self.name = split_name_capitalized.join(' ')
  end
end
