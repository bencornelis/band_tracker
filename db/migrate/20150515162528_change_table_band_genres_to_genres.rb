class ChangeTableBandGenresToGenres < ActiveRecord::Migration
  def change
    rename_table(:band_genres, :genres)
  end
end
