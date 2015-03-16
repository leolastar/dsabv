class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime   :start_time
      t.datetime   :end_time
      t.integer    :total_capacity
      t.integer    :remaining_capacity
      t.belongs_to :event
      t.timestamps
    end
  end
end
