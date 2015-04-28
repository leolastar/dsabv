class CreateBuddyWalks < ActiveRecord::Migration
  def change
    create_table :buddy_walks do |t|
      t.string :title
      t.string :place
      t.text :description
      t.date :date
      t.timestamps
    end
  end
end
