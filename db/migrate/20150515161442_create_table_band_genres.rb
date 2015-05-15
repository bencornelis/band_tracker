class CreateTableBandGenres < ActiveRecord::Migration
  def change
    create_table(:band_genres) do |t|
      t.column(:genre, :string)
      t.column(:band_id, :integer)

      t.timestamps()
    end
  end
end
