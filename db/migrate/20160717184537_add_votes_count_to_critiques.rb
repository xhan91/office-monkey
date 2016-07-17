class AddVotesCountToCritiques < ActiveRecord::Migration
  def change
    change_table :critiques do |t|
      t.integer :votes_count
    end
  end
end
