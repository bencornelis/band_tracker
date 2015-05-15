class CreateTableBands < ActiveRecord::Migration
  def change
    create_table(:bands) do |t|
      t.column(:name, :string)
      t.column(:origin, :string)
      t.column(:year_founded, :integer)

      t.timestamps()
    end
  end
end
