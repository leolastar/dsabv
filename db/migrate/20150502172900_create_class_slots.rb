class CreateClassSlots < ActiveRecord::Migration
  def change
    create_table :class_slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_capacity
      t.integer :remaining_capacity
      t.integer :ds_class_id

      t.timestamps
    end
  end
end
