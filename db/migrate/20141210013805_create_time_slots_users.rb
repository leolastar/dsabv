class CreateTimeSlotsUsers < ActiveRecord::Migration
  def change
    create_table :time_slots_users do |t|
      t.belongs_to :time_slot
      t.belongs_to :user
    end
  end
end
