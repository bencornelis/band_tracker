class CreateJoinTableBandsVenues < ActiveRecord::Migration
  def change
    create_join_table(:bands, :venues)
  end
end
